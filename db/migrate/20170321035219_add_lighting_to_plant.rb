class AddLightingToPlant < ActiveRecord::Migration[5.0]
  def change
    add_column :plants, :lighting, :string
    add_index :plants, :lighting
  end
end
