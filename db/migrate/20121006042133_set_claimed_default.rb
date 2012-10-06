class SetClaimedDefault < ActiveRecord::Migration
  def up
  	change_column :bars, :claimed, :boolean, :default => false
  end

  def down
  end
end
