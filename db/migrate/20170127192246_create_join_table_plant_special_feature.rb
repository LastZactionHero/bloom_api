class CreateJoinTablePlantSpecialFeature < ActiveRecord::Migration[5.0]
  def change
    create_join_table :plants, :special_features do |t|
      t.index [:plant_id, :special_feature_id], name: 'join_plant_sf'
      t.index [:special_feature_id, :plant_id], name: 'join_sf_plant'
    end
  end
end
