class RemoveConstraintFromSchools < ActiveRecord::Migration[5.0]
  def self.up
    execute "ALTER TABLE schools DROP CONSTRAINT enforce_srid_geometry"
  end

  def self.down
    execute "ALTER TABLE schools ADD CONSTRAINT enforce_srid_geometry CHECK (st_srid(geometry) = 26986)"
  end
end
