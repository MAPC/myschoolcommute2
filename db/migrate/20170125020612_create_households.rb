class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.references :survey_set, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
