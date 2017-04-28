class CreateCombinationTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :combination_templates do |t|
      t.jsonb :starting_plants

      t.timestamps
    end
  end
end
