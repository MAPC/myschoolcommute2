require 'uri'
require 'net/http'

class SurveyResponse < ActiveRecord::Base
  after_save :find_intersecting_shed, if: :geometry_changed?
  after_save :calculate_distance
  belongs_to :survey
  has_one :school, through: :survey

  def find_intersecting_shed
    update_columns(shed: IntersectionQuery.new(geometry.to_s, school).execute)
  end

  def calculate_distance
    # this needs to be refactored. this is lifted from the old app.
    url = URI("http://maps.googleapis.com/maps/api/directions/json?sensor=false&origin=#{geometry.y},#{geometry.x}&destination=#{school.geometry.y},#{school.geometry.x}")
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
      miles = -9999
    end
    
    update_columns({
      distance: miles
    })

  end
end
