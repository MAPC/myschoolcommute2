require 'rgeo/geo_json'
json.extract! school, :id, :created_at, :updated_at, :name
json.url school_url(school, format: :json)