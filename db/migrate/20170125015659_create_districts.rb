class CreateDistricts < ActiveRecord::Migration

  enable_extension "postgis"
  enable_extension "pgrouting"

  def change
    create_table :districts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
