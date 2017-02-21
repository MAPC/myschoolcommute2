class IntersectionQuery

  def initialize(point_wkt, school)
    @point_wkt = point_wkt
    @school = school
  end

  def execute
    School.select(
      "
        trunc(
          log(2, 
            (
              (ST_Intersects(schools.shed_20, ST_Transform(geometry(ST_GeomFromText('#{@point_wkt}', 4326)),26986)) is TRUE::int::bit) ||
              (ST_Intersects(schools.shed_15, ST_Transform(geometry(ST_GeomFromText('#{@point_wkt}', 4326)),26986)) is TRUE::int::bit) ||
              (ST_Intersects(schools.shed_10, ST_Transform(geometry(ST_GeomFromText('#{@point_wkt}', 4326)),26986)) is TRUE::int::bit) ||
              (ST_Intersects(schools.shed_05, ST_Transform(geometry(ST_GeomFromText('#{@point_wkt}', 4326)),26986)) is TRUE::int::bit) || 
              (1::int::bit)
            )::bit(5)::int
          )
        ) AS shed
      "
    ).where(id: @school.id).first.shed.to_i
  end
end
