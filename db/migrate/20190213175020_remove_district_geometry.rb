class RemoveDistrictGeometry < ActiveRecord::Migration[5.0]
  def change
    remove_column :districts, :geometry
  end
end
