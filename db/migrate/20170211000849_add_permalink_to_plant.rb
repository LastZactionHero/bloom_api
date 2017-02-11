class AddPermalinkToPlant < ActiveRecord::Migration[5.0]
  def change
    add_column :plants, :permalink, :string
    add_index :plants, :permalink

    Plant.reset_column_information
    Plant.all.each do |plant|
      plant.save
    end
  end
end
