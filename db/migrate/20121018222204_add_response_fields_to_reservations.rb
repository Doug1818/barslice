class AddResponseFieldsToReservations < ActiveRecord::Migration
  def change
  	add_column :reservations, :bar_response, :integer
  	add_column :reservations, :user_response, :integer
  end
end
