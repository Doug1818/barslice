class RemoveUnnecessaryRoomAttributes < ActiveRecord::Migration
  def up
  	remove_column :rooms, :min_head_count
  	remove_column :rooms, :max_head_count
  	remove_column :rooms, :min_spend
  	remove_column :rooms, :per_person
  end

  def down
  end
end
