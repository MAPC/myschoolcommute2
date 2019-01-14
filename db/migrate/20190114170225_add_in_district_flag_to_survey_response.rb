class AddInDistrictFlagToSurveyResponse < ActiveRecord::Migration[5.0]
  def change
    add_column :survey_responses, :in_district, :boolean, default: false
  end
end
