require 'rgeo/geo_json'
json.extract! school, :id, :created_at, :updated_at
json.url school_url(school, format: :json)
json.shed_05 RGeo::GeoJSON.encode(school.shed_05)
json.shed_10 RGeo::GeoJSON.encode(school.shed_10)
json.shed_15 RGeo::GeoJSON.encode(school.shed_15)
json.shed_20 RGeo::GeoJSON.encode(school.shed_20)