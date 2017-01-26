class CreateGrowthRates < ActiveRecord::Migration[5.0]
  def change
    create_table :growth_rates do |t|
      t.text :name

      t.timestamps
    end
    add_index :growth_rates, :name
  end
end
