class CreateLightNeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :light_needs do |t|
      t.text :name

      t.timestamps
    end
    add_index :light_needs, :name
  end
end
