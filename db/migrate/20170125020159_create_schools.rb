class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :schid
      t.decimal :latitude
      t.decimal :longitude
      t.references :district, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
