class WalkshedQuery

  def execute
    begin
      # AR execute walkshed_generation_sql
    rescue
    ensure
    end
  end

  private

  def walkshed_generation_sql
    "
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
    "
  end
end