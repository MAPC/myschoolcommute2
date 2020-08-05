class AddSurveyResponseSourceColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :survey_responses, :is_bulk_entry, :boolean
  end
end
