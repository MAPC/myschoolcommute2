class WalkshedQuery

  def initialize(school_id)
    @school_id = school_id
  end

  def execute
    # begin
      ActiveRecord::Base.connection.execute(walkshed_generation_sql(@school_id))
    # rescue
    # ensure
    # end
  end

  # private

  # this is confirmed functional, with LOTS of idiosyncratic dependencies server-side.
  # https://github.com/PostgresApp/PostgresApp/issues/54
  # on Mac with postgres app, we must run postgres -D /Users/mgardner/Library/Application\ Support/Postgres/var-9.6
  # just so that the server process can actually find the pogrouting functions

  # in production, the db server is linux, and this may be less of an issue

  # the network data has been projected to - SOMETHING - (not just 0), which is very important for the
  # query, which tries to set the SRID on-the-fly. 

  # the schema must also use float8, not float4. some pgrouting features are very strict about typecasting.
  # other columns (like source and target) must be int4.

  # the query takes several minutes to run, probably because our test data is in boston, which includes a very dense and
  # complicated network (as opposed to suburban networks)

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