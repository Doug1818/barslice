class AddMoreStripeFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_card_type, :string
    add_column :users, :stripe_card_last4, :string
  end
end
