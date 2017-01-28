class CreateJoinTableFlowerAttributePlant < ActiveRecord::Migration[5.0]
  def change
    create_join_table :flower_attributes, :plants do |t|
      t.index [:flower_attribute_id, :plant_id], name: 'join_fa_plant'
      t.index [:plant_id, :flower_attribute_id], name: 'join_plant_fa'
    end
  end
end
