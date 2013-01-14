class AddRespolicyAcceptedToReservations < ActiveRecord::Migration
  def change
  	add_column :reservations, :respolicy_accepted, :boolean, :default => false
  end
end
