class AddSoilMoistureToPlant < ActiveRecord::Migration[5.0]
  def change
    add_column :plants, :soil_moisture, :string
    add_index :plants, :soil_moisture
  end
end
