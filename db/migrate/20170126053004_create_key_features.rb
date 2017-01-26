class CreateKeyFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :key_features do |t|
      t.text :name

      t.timestamps
    end
    add_index :key_features, :name
  end
end
