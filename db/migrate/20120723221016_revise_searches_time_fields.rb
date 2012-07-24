class ReviseSearchesTimeFields < ActiveRecord::Migration
  def up
  	rename_column :searches, :time, :start_time
  	add_column :searches, :end_time, :time
  end

  def down
  end
end
