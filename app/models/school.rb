require 'json'
require 'rgeo/geos/geos_c_impl'
CARTO_SQL_API_ENDPOINT = 'http://mapc-admin.carto.com/api/v2'

class School < ActiveRecord::Base
  belongs_to :district
  has_many :surveys
  has_many :survey_responses, through: :surveys
  before_save :transform_geometry

  after_save :update_sheds, if: :geometry_changed?

  scope :active, -> () {
    self.where(id: Survey.active.pluck(:school_id))
  }

  def wgs84_lat
    School.select('ST_X(ST_Transform(geometry,4326)), ST_Y(ST_Transform(geometry,4326)),id').find(id).st_y
  end

  def wgs84_lng
    School.select('ST_X(ST_Transform(geometry,4326)), ST_Y(ST_Transform(geometry,4326)),id').find(id).st_x
  end

  # refactor this
  def active_surveys
    surveys.where(id: Survey.active.pluck(:id))
  end

  # Through AR Base, transform to 4326, cast as GeoJSON, then find the first row in the result and get
  # the geom. Return an empty array if nil.
  # needs refactoring ASAP.
  def to_wgs84(column)
    sql = "SELECT ST_AsGeoJSON(ST_Transform(#{column}, 4326)) as transformedgeo from schools where id=#{id}"
    result = ActiveRecord::Base.establish_connection.connection.execute(sql)[0]['transformedgeo'] || '[]'
    JSON.parse(result)
  end

  def recent_surveys_since(date=24.hours.ago)
    survey_responses.where('survey_responses.created_at > ?', date).count
  end

  def total_surveys
    survey_responses.count
  end

  def has_active_survey?
    surveys.where('begin <= ? AND "end" >= ?', now, now).present?
  end

  def muni_id
    if read_attribute(:muni_id).nil?
      find_intersecting_municipality
    else
      read_attribute(:muni_id)
    end
  end

  def results_to_csv
    if survey_responses.any?
      csv  = []
      query = "COPY (SELECT * FROM melted_survey_responses WHERE survey_id IN (#{surveys.pluck(:id).join(',')})) TO STDOUT WITH (FORMAT CSV, HEADER TRUE, FORCE_QUOTE *, ESCAPE E'\\\\');"

      conn = ActiveRecord::Base.connection.raw_connection
      conn.copy_data(query) do
        while row = conn.get_copy_data
          csv.push(row)
        end
      end
      csv.join("\n")
    else
      "No Results Found."
    end
  end

  def find_intersecting_municipality
    sql = "\
    SELECT muni_id FROM ma_municipalities \
    WHERE \
    ST_Intersects(\
        ST_Transform(the_geom, 26986), \
        ST_PointFromText ('#{geometry.to_s}', 26986)\
    )"

    uri = "#{CARTO_SQL_API_ENDPOINT}/sql?q=#{sql}"
    url = URI(uri)
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    request["content-type"] = 'application/json'
    request["cache-control"] = 'no-cache'
    response = http.request(request)
    json = JSON.parse(response.read_body)

    begin
      muni_id = JSON.parse(response.read_body)['rows'][0]['muni_id']
    rescue
      muni_id = nil
    end

    update_columns({
      muni_id: muni_id
    })

    muni_id
  end

  def update_sheds
    # TODO: active job or sidekick or rabbit mq
    sheds = WalkshedQuery.new(id).execute

    # adds sheds to columns
    update_columns({  shed_05: sheds[0]['_05'],
                      shed_10: sheds[0]['_10'],
                      shed_15: sheds[0]['_15'],
                      shed_20: sheds[0]['_20'] })

    # converts sheds into rings
    shed_10_ring = shed_10.difference(shed_05).to_s
    shed_15_ring = shed_15.difference(shed_10).to_s
    shed_20_ring = shed_20.difference(shed_15).to_s

    # updates with new rings
    update_columns({  shed_10: shed_10_ring,
                      shed_15: shed_15_ring,
                      shed_20: shed_20_ring  })
  end

  def now
    DateTime.now
  end

  def transform_geometry
    # Ugly hack to transform SRID 4326 input from leaflet to the expected SRID of 26986
    point = RGeo::Cartesian.factory(srid: 4326, proj4: '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs').point(self.geometry.x, self.geometry.y)
    ma_factory = RGeo::Cartesian.factory(srid: 26986, proj4: '+proj=lcc +lat_1=42.68333333333333 +lat_2=41.71666666666667 +lat_0=41 +lon_0=-71.5 +x_0=200000 +y_0=750000 +ellps=GRS80 +datum=NAD83 +units=m +no_defs')
    begin
      self.geometry = RGeo::Feature.cast(point, factory: ma_factory, project: true)
    rescue
      self.geometry
    end
  end
end
