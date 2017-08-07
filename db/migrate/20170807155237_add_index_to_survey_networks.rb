class AddIndexToSurveyNetworks < ActiveRecord::Migration[5.0]
  def change
    add_index :survey_network_bike, :geometry, using: :gist
    add_index :survey_network_walk, :geometry, using: :gist
  end
end
