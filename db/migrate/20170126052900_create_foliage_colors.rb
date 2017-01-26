class CreateFoliageColors < ActiveRecord::Migration[5.0]
  def change
    create_table :foliage_colors do |t|
      t.text :name

      t.timestamps
    end
    add_index :foliage_colors, :name
  end
end
