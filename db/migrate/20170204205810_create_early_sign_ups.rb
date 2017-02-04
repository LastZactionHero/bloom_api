class CreateEarlySignUps < ActiveRecord::Migration[5.0]
  def change
    create_table :early_sign_ups do |t|
      t.text :email

      t.timestamps
    end
  end
end
