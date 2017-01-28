class CreateJoinTablePlantZone < ActiveRecord::Migration[5.0]
  def change
    create_join_table :plants, :zones do |t|
      t.index [:plant_id, :zone_id]
      t.index [:zone_id, :plant_id]
    end
  end
end
