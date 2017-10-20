class UpdateMeltedSurveyResponsesToVersion2 < ActiveRecord::Migration[5.0]
  def change
    update_view :melted_survey_responses, version: 2, revert_to_version: 1
  end
end
