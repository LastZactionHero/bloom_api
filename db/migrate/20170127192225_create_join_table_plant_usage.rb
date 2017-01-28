class CreateJoinTablePlantUsage < ActiveRecord::Migration[5.0]
  def change
    create_join_table :plants, :usages do |t|
      t.index [:plant_id, :usage_id]
      t.index [:usage_id, :plant_id]
    end
  end
end
