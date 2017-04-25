class AddSimilarityIndexToPlant < ActiveRecord::Migration[5.0]
  def change
    add_column :plants, :similarity_index, :float, default: 0.0
    add_index :plants, :similarity_index
  end
end
