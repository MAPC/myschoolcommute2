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

    while miles == nil && retries <= 15
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
    csv.insert(1,'ID of Survey Response in the Database,ID of the Survey associated with the survey response in the database.,Distance from street intersection near the home and the destination school as calculated by the Google Maps API,Point location of the intersection near the survey respondent’s home. Provided on a 4326 projected plane.,When the survey response was created.,When the survey response was last modified.,Integer value that enumerates the type of walk shed the point is in. ,Do you usually drop off your child on your way to work or another destination?,How does your child get home FROM school on most days?,What grade is your child in?,Do you usually pick up your child on your way from work or another origin?,How does your child get TO school on most days?,ID of the school associated with the survey in the database.,How many people in your household have a driver license?,How many vehicles do you have in your household?,DOE Org Code for the Respondent’s School')
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

      # this needs to be refactored. this is lifted from the old app.
      url = URI("http://maps.googleapis.com/maps/api/directions/json?sensor=false&origin=#{origin_lat},#{origin_lng}&destination=#{dest_lat},#{dest_lng}")
      http = Net::HTTP.new(url.host, url.port)

      request = Net::HTTP::Get.new(url)
      request["content-type"] = 'application/json'
      request["cache-control"] = 'no-cache'
      response = http.request(request)

      begin
        meters = JSON.parse(response.read_body)['routes'][0]['legs'][0]['distance']['value']
        miles = meters * 0.000621371
      rescue Exception => e
        Raven.capture_exception(e, :extra => { 'lat': origin_lat, 'lng': origin_lng })
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
