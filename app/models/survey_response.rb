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
    
    # this needs to be refactored. this is lifted from the old app.
    url = URI("http://maps.googleapis.com/maps/api/directions/json?sensor=false&origin=#{geometry.y},#{geometry.x}&destination=#{school.wgs84_lat},#{school.wgs84_lng}")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    request["content-type"] = 'application/json'
    request["cache-control"] = 'no-cache'
    response = http.request(request)
    json = JSON.parse(response.read_body)
    
    begin
      meters = JSON.parse(response.read_body)['routes'][0]['legs'][0]['distance']['value']
      miles = meters * 0.000621371
    rescue
      miles = nil
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
    csv.join("\n")
  end

  private
    def non_blank_grade_value(column)
      (0..19).each do |grade_num|
        unless self["#{column}_#{grade_num}"].blank?
          return self["#{column}_#{grade_num}"]
        end
      end

      nil
    end

end
