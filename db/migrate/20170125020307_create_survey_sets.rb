class CreateSurveySets < ActiveRecord::Migration
  def change
    create_table :survey_sets do |t|
      t.datetime :start
      t.datetime :end
      t.references :school, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
