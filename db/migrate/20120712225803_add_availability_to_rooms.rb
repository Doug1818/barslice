class AddAvailabilityToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :mon1, :time
    add_column :rooms, :mon2, :time
    add_column :rooms, :tues1, :time
    add_column :rooms, :tues2, :time
    add_column :rooms, :wed1, :time
    add_column :rooms, :wed2, :time
    add_column :rooms, :thurs1, :time
    add_column :rooms, :thurs2, :time
    add_column :rooms, :fri1, :time
    add_column :rooms, :fri2, :time
    add_column :rooms, :sat1, :time
    add_column :rooms, :sat2, :time
    add_column :rooms, :sun1, :time
    add_column :rooms, :sun2, :time
  end
end
