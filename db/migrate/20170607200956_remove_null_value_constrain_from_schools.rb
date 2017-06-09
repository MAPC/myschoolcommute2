class RemoveNullValueConstrainFromSchools < ActiveRecord::Migration[5.0]
  def change
    change_column :schools, :survey_active, :boolean, :null => true
  end
end
