class AddAvailabilityToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :mon1, :integer
    add_column :rooms, :mon1ap, :boolean
    add_column :rooms, :mon2, :integer
    add_column :rooms, :mon2ap, :boolean
    add_column :rooms, :tues1, :integer
    add_column :rooms, :tues1ap, :boolean
    add_column :rooms, :tues2, :integer
    add_column :rooms, :tues2ap, :boolean
    add_column :rooms, :wed1, :integer
    add_column :rooms, :wed1ap, :boolean
    add_column :rooms, :wed2, :integer
    add_column :rooms, :wed2ap, :boolean
    add_column :rooms, :thurs1, :integer
    add_column :rooms, :thurs1ap, :boolean
    add_column :rooms, :thurs2, :integer
    add_column :rooms, :thurs2ap, :boolean
    add_column :rooms, :fri1, :integer
    add_column :rooms, :fri1ap, :boolean
    add_column :rooms, :fri2, :integer
    add_column :rooms, :fri2ap, :boolean
    add_column :rooms, :sat1, :integer
    add_column :rooms, :sat1ap, :boolean
    add_column :rooms, :sat2, :integer
    add_column :rooms, :sat2ap, :boolean
    add_column :rooms, :sun1, :integer
    add_column :rooms, :sun1ap, :boolean
    add_column :rooms, :sun2, :integer
    add_column :rooms, :sun2ap, :boolean
  end
end
