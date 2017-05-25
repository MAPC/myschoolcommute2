require 'rgeo/geo_json'
json.extract! school, :id, :created_at, :updated_at
json.url school_url(school, format: :json)
json.wgs84_lat  @school.wgs84_lat
json.wgs84_lng @school.wgs84_lng
json.shed_05 @school.to_wgs84('shed_05')
json.shed_10 @school.to_wgs84('shed_10')
json.shed_15 @school.to_wgs84('shed_15')
json.shed_20 @school.to_wgs84('shed_20')
json.surveys @school.surveys do |survey|
  json.id survey.id
  json.begin survey.begin
  json.end survey.end
  json.survey_responses survey.survey_responses do |survey_response|
    json.geometry RGeo::GeoJSON.encode(survey_response.geometry)
    json.shed survey_response.shed
  end
end
