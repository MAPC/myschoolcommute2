class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :schid
      t.st_point :geometry, srid: 4326, geographic: false
      t.geometry :shed_05, srid: 26986, geographic: false
      t.geometry :shed_10, srid: 26986, geographic: false
      t.geometry :shed_15, srid: 26986, geographic: false
      t.geometry :shed_20, srid: 26986, geographic: false

      t.references :district, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
