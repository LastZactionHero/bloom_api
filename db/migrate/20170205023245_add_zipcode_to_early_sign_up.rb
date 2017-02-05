class AddZipcodeToEarlySignUp < ActiveRecord::Migration[5.0]
  def change
    add_column :early_sign_ups, :zipcode, :string
  end
end
