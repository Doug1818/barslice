class FixSpecialsColumnName < ActiveRecord::Migration
  def up
  	rename_column :specials, :wesnesday, :wednesday
  end

  def down
  end
end
