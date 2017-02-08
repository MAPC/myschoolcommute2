class School < ActiveRecord::Base
  belongs_to :district
  has_many :surveys

  scope :with_active_surveys, -> () {
    self.joins(:surveys)
        .where('surveys.begin < ? AND surveys.end > ?', DateTime.now, DateTime.now)
  }

  def has_active_survey?
    surveys.where('begin < ? AND end > ?', now, now).present?
  end

  private 

  def walkshed_generator
    '''
        WITH paths as (#{})
        SELECT ST_AsEWKT(
            ST_MakeValid(
                ST_Transform(
                    ST_Union(
                        array(
                            select ST_BUFFER(geometry, 100) from (#{}) as BIKE
                        )
                    ),
                    26986
                )
            )
        ) as _20,
        ST_AsEWKT(
            ST_MakeValid(
                ST_Transform(
                    ST_Union(
                        array(
                            select ST_BUFFER(geometry, 100) from paths where cost < 1.5
                        )
                    ),
                    26986
                )
            )
        ) as _15,
        ST_AsEWKT(
            ST_MakeValid(
                ST_Transform(
                    ST_Union(
                        array(
                            select ST_BUFFER(geometry, 100) from paths where cost < 1.0
                        )
                    ),
                    26986
                )
            )
        ) as _10,
        ST_AsEWKT(
            ST_MakeValid(
                ST_Transform(
                    ST_Union(
                        array(
                            select ST_BUFFER(geometry, 100) from paths where cost < 0.5
                        )
                    ),
                    26986
                )
            )
        ) as _05
    '''
  end

  def now
    DateTime.now
  end

end

# https://mapzen.com/documentation/mobility/isochrone/api-reference/
# https://matrix.mapzen.com/isochrone?json={"locations":[{"lat":"42.118476","lon":"-70.953508"}],"costing":"pedestrian","denoise":0.3,"polygons":true,"generalize":50,"costing_options":{"pedestrian":{"use_ferry":0}},"contours":[{"time":10},{"time":20},{"time":30},{"time":40}]}
