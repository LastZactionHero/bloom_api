class CreateBedTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :bed_templates do |t|
      t.string :name
      t.integer :design_width
      t.integer :design_height
      t.jsonb :config

      t.timestamps
    end
  end
end
