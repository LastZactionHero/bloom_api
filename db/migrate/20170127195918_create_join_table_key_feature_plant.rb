class CreateJoinTableKeyFeaturePlant < ActiveRecord::Migration[5.0]
  def change
    create_join_table :key_features, :plants do |t|
      t.index [:key_feature_id, :plant_id]
      t.index [:plant_id, :key_feature_id]
    end
  end
end
