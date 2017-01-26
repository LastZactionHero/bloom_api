class CreateUsages < ActiveRecord::Migration[5.0]
  def change
    create_table :usages do |t|
      t.text :name

      t.timestamps
    end
    add_index :usages, :name
  end
end
