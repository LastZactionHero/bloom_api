class CreatePlantTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :plant_types do |t|
      t.text :name

      t.timestamps
    end
    add_index :plant_types, :name
  end
end
