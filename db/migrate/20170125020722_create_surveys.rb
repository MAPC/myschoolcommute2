class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :question
      t.string :mode
      t.references :household, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
