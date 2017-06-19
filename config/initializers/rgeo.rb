RGeo::ActiveRecord::SpatialFactoryStore.instance.tap do |config|
  # this was causing many issues but let's return it later
  config.default = RGeo::Cartesian.factory(:srid => 26986)

  config.register(RGeo::Cartesian.factory(srid: 4326), sql_type: 'geometry(Point,4326)', geo_type: 'Point', srid: 4326)
end
