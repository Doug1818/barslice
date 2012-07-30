class FixRestrictionsColumnNames < ActiveRecord::Migration
  def up
  	rename_column :restrictions, :start_time, :before
  	rename_column :restrictions, :end_time, :after
  end

  def down
  end
end
