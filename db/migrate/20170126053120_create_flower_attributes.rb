class CreateFlowerAttributes < ActiveRecord::Migration[5.0]
  def change
    create_table :flower_attributes do |t|
      t.text :name

      t.timestamps
    end
    add_index :flower_attributes, :name
  end
end
