class CreateDistricts < ActiveRecord::Migration

  def change
    enable_extension "postgis"
    # enable_extension "pgrouting"

    create_table :districts do |t|
      t.string :name

      t.string :distname
      t.string :slug
      t.string :startgrade
      t.string :endgrade
      t.string :distcode4
      t.string :distcode8
      t.integer :districtid_id

      t.geometry :geometry, srid: 26986, geographic: false

      t.timestamps null: false
    end
  end
end
