class FixMoreColumnsNames < ActiveRecord::Migration
  def up
  	rename_column :hrsranges, :start, :open
  	rename_column :hrsranges, :end, :close
  end

  def down
  end
end
