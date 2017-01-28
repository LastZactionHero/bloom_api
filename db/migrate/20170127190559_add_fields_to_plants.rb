class AddFieldsToPlants < ActiveRecord::Migration[5.0]
  def change
    add_column :plants, :watering_needs_raw, :text
    add_column :plants, :average_size_raw, :text
  end
end
