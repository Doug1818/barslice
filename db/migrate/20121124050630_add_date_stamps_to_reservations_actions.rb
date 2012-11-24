class AddDateStampsToReservationsActions < ActiveRecord::Migration
  def change
  	add_column :reservations, :bar_accepts_date, :datetime
  	add_column :reservations, :bar_rejects_date, :datetime
  	add_column :reservations, :user_accepts_date, :datetime
  	add_column :reservations, :user_rejects_date, :datetime
  end
end
