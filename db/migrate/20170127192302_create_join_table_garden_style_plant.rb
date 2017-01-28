class CreateJoinTableGardenStylePlant < ActiveRecord::Migration[5.0]
  def change
    create_join_table :garden_styles, :plants do |t|
      t.index [:garden_style_id, :plant_id]
      t.index [:plant_id, :garden_style_id]
    end
  end
end
