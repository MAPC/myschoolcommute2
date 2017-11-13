class UpdateMeltedSurveyResponsesToVersion3 < ActiveRecord::Migration[5.0]
  def change
    update_view :melted_survey_responses, version: 3, revert_to_version: 2
  end
end
