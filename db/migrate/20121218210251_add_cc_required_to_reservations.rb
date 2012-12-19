class AddCcRequiredToReservations < ActiveRecord::Migration
  def change
  	add_column :reservations, :cc_required, :boolean, :default => false
  end
end
