class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.date :begin
      t.date :end

      t.references :school, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
