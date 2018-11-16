class UpdateSchoolGeometrySrid < ActiveRecord::Migration[5.0]
  def up
    execute "SELECT UpdateGeometrySRID('schools','geometry',26986)"
  end

  def down
    execute "SELECT UpdateGeometrySRID('schools','geometry',0)"
  end
end
