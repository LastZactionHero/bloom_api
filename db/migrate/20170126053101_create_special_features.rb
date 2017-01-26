class CreateSpecialFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :special_features do |t|
      t.text :name

      t.timestamps
    end
    add_index :special_features, :name
  end
end
