class CreateSurveyResponses < ActiveRecord::Migration
  def change
    create_table :survey_responses do |t|
      t.st_point :geometry, srid: 4326, geographic: false
      t.string :question
      t.string :mode
      t.integer :shed
      t.float :distance
      t.references :survey, index: true, foreign_key: true

      20.times do |i|
        t.string "grade_#{i}".to_sym
        t.string "to_school_#{i}".to_sym
        t.string "dropoff_#{i}".to_sym
        t.string "from_school_#{i}".to_sym
        t.string "pickup_#{i}".to_sym
        t.string "nr_vehicles_#{i}".to_sym
        t.string "nr_licenses_#{i}".to_sym
      end

      t.timestamps null: false
    end
  end
end
