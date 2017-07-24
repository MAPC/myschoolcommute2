class AddOldIdToSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :old_id, :integer
  end
end
