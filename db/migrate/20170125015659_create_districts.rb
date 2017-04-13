class CreateDistricts < ActiveRecord::Migration

  def change
    enable_extension "postgis"
    enable_extension "pgrouting"

    create_table :districts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
