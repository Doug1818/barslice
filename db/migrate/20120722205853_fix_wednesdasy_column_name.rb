class FixWednesdasyColumnName < ActiveRecord::Migration
  def up
  	rename_column :restrictions, :wednesdasy, :wednesday
  end

  def down
  end
end
