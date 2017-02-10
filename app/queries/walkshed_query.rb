class WalkshedQuery

  def initialize(school_id)
    @school_id = school_id
  end

  def execute
    begin
      ActiveRecord::Base.connection.execute(walkshed_generation_sql(@school_id))
    rescue
    ensure
    end
  end

  # private

  def paths_sql(school_id, network='survey_network_walk', miles=1.5)
    school = "
        ST_SetSRID(
            (SELECT geometry FROM schools WHERE id = #{school_id}), 26986
        )
      "

    closest_street = "
        (SELECT source from #{network} ORDER BY
            #{school} <-> geometry
            asc limit 1
        )
      "

    "
      SELECT ogc_fid, geometry, route.cost from #{network} as w
      JOIN
      (SELECT * FROM
         pgr_drivingdistance(
              'SELECT ogc_fid as id, source, target, miles AS cost
               FROM #{network}
               WHERE geometry && ST_Buffer(ST_Envelope(#{school}), 8000)'
              , #{closest_street}, #{miles}, false, false
          )) AS route
      ON
      w.target = route.id1
    "
  end

  def walkshed_generation_sql(school_id)
    query = paths_sql(school_id, 'survey_network_walk', miles=1.5)
    bike_query = paths_sql(school_id, 'survey_network_bike', 2.0)

    "
      WITH paths as (#{query})
      SELECT ST_AsEWKT(
          ST_MakeValid(
              ST_Transform(
                  ST_Union(
                      array(
                          select ST_BUFFER(geometry, 100) from (#{bike_query}) as BIKE
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
    "
  end
end