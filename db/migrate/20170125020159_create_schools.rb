class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :schid
      t.st_point :geometry, srid: 26986, geographic: false
      t.multi_polygon :shed_05, srid: 26986, geographic: false
      t.multi_polygon :shed_10, srid: 26986, geographic: false
      t.multi_polygon :shed_15, srid: 26986, geographic: false
      t.multi_polygon :shed_20, srid: 26986, geographic: false

      t.references :district, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
