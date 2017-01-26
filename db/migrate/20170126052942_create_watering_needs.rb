class CreateWateringNeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :watering_needs do |t|
      t.text :name

      t.timestamps
    end
    add_index :watering_needs, :name
  end
end
