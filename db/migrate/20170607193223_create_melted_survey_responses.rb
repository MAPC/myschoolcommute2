class CreateMeltedSurveyResponses < ActiveRecord::Migration[5.0]
  def change
    create_view :melted_survey_responses
  end
end
