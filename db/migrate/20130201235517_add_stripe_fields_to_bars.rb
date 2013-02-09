class AddStripeFieldsToBars < ActiveRecord::Migration
  def change
    add_column :bars, :stripe_access_token, :string
    add_column :bars, :stripe_publishable_key, :string
    add_column :bars, :stripe_user_id, :string
  end
end
