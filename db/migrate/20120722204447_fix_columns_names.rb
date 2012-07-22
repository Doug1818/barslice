class FixColumnsNames < ActiveRecord::Migration
  def up
  	rename_column :restrictions, :start, :start_date
  	rename_column :restrictions, :end, :end_date
  end

  def down
  end
end
