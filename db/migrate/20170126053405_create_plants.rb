class CreatePlants < ActiveRecord::Migration[5.0]
  def change
    create_table :plants do |t|
      t.text :common_name
      t.text :scientific_name
      t.text :source_url
      t.text :image_url
      t.text :description
      t.float :avg_height
      t.float :avg_width
      t.text :care_info
      t.boolean :store_available
      t.text :store_url
      t.float :store_cost
      t.integer :leave_type_id
      t.integer :growth_rate_id
      t.integer :flower_color_id
      t.integer :foliage_color_id
      t.integer :light_need_id
      t.integer :watering_need_id

      t.timestamps
    end

    add_index :plants, :common_name
    add_index :plants, :scientific_name
    add_index :plants, :avg_height
    add_index :plants, :avg_width
    add_index :plants, :store_available
    add_index :plants, :leave_type_id
    add_index :plants, :growth_rate_id
    add_index :plants, :flower_color_id
    add_index :plants, :foliage_color_id
    add_index :plants, :light_need_id
    add_index :plants, :watering_need_id
  end
end
