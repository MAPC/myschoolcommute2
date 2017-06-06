class UpdateForeignKeySurveys < ActiveRecord::Migration[5.0]
  def change
    # remove the old foreign_key
    remove_foreign_key :survey_responses, :surveys
  end
end
