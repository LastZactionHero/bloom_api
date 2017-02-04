class AddNewsletterToEarlySignUp < ActiveRecord::Migration[5.0]
  def change
    add_column :early_sign_ups, :newsletter, :boolean, default: false
  end
end
