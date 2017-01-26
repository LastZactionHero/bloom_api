class CreateGardenStyles < ActiveRecord::Migration[5.0]
  def change
    create_table :garden_styles do |t|
      t.text :name

      t.timestamps
    end
    add_index :garden_styles, :name
  end
end
