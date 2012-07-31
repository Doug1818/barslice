class ChangeTimeFormats < ActiveRecord::Migration
  def up
  	remove_column :hrsranges, :open
  	remove_column :hrsranges, :close
  	remove_column :restrictions, :before
  	remove_column :restrictions, :after
  	remove_column :searches, :start_time
  	remove_column :searches, :end_time

  	add_column :hrsranges, :open, :integer
  	add_column :hrsranges, :close, :integer
  	add_column :restrictions, :before, :integer
  	add_column :restrictions, :after, :integer
  	add_column :searches, :start_time, :integer
  	add_column :searches, :end_time, :integer
  end

  def down
  end
end
