class AddRoomIdToRestrictions < ActiveRecord::Migration
  def change
    add_column :restrictions, :room_id, :integer
  end
end
