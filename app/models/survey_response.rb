require 'uri'
require 'net/http'

class SurveyResponse < ActiveRecord::Base
  after_save :find_intersecting_shed, if: :geometry_changed?
  after_save :calculate_distance
  belongs_to :survey
  has_one :school, through: :survey

  validates :geometry, presence: true


  def find_intersecting_shed
    update_columns(shed: IntersectionQuery.new(geometry.to_s, school).execute)
  end

  def calculate_distance
    retries = 0
    miles = nil

    while miles == nil && retries <= 8
      retries += 1
      miles = get_distance()
    end

    update_columns({
      distance: miles
    })
  end

  def to_school
    non_blank_grade_value('to_school')
  end

  def from_school
    non_blank_grade_value('from_school')
  end

  def self.to_csv
    csv  = []
    query = "COPY (SELECT * FROM melted_survey_responses) TO STDOUT WITH (FORMAT CSV, HEADER TRUE, FORCE_QUOTE *, ESCAPE E'\\\\');"

    conn = ActiveRecord::Base.connection.raw_connection
    conn.copy_data(query) do
      while row = conn.get_copy_data
        csv.push(row)
      end
    end
    csv.join
  end

  private
    def lat_lng(a, b)
      if a < 0 && b > 0
        return b, a
      else
        return a, b
      end
    end

    def get_distance
      origin_lat, origin_lng = lat_lng(geometry.x, geometry.y)
      dest_lat, dest_lng = lat_lng(school.wgs84_lat, school.wgs84_lng)

      google_api_params = [
        "sensor=false",
        "origin=#{origin_lat},#{origin_lng}",
        "destination=#{dest_lat},#{dest_lng}",
        "key=#{Rails.application.secrets.maps_api_key}",
      ].join('&')
      google_api_url = "https://maps.googleapis.com/maps/api/directions/json?" + google_api_params
      url = URI(google_api_url)

      request = Net::HTTP::Get.new(url)
      request["content-type"] = 'application/json'
      request["cache-control"] = 'no-cache'

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      response = http.request(request)

      begin
        meters = JSON.parse(response.read_body)['routes'][0]['legs'][0]['distance']['value']
        miles = meters * 0.000621371
      rescue Exception => e
        Raven.capture_exception(e, :extra => {
          'lat': origin_lat,
          'lng': origin_lng,
          'req_url': url,
        })
        miles = nil
      end

      return miles
    end

    def non_blank_grade_value(column)
      (0..19).each do |grade_num|
        unless self["#{column}_#{grade_num}"].blank?
          return self["#{column}_#{grade_num}"]
        end
      end

      nil
    end

end
