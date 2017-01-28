class AddPlantTypeIdToPlants < ActiveRecord::Migration[5.0]
  def change
    add_column :plants, :plant_type_id, :integer
    add_index :plants, :plant_type_id
  end
end
