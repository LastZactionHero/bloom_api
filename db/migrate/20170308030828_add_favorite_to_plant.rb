class AddFavoriteToPlant < ActiveRecord::Migration[5.0]
  def change
    add_column :plants, :favorite, :boolean, default: false
    add_index :plants, :favorite
  end
end
