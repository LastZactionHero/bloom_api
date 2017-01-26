class CreateFlowerColors < ActiveRecord::Migration[5.0]
  def change
    create_table :flower_colors do |t|
      t.text :name

      t.timestamps
    end
    add_index :flower_colors, :name
  end
end
