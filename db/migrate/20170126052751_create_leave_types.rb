class CreateLeaveTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_types do |t|
      t.text :name

      t.timestamps
    end
    add_index :leave_types, :name
  end
end
