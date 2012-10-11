class RemoveUnnecessaryReservationAttributes < ActiveRecord::Migration
  def up
  	remove_column :reservations, :name
  	remove_column :reservations, :email
  	remove_column :reservations, :phone
  	add_column :reservations, :user_id, :integer
  end

  def down
  end
end
