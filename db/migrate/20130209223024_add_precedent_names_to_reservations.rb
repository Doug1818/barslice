class AddPrecedentNamesToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :user_name, :string
    add_column :reservations, :bar_name, :string
    add_column :reservations, :room_name, :string
  end
end
