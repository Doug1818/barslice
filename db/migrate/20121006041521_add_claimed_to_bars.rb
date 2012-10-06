class AddClaimedToBars < ActiveRecord::Migration
  def change
    add_column :bars, :claimed, :boolean
  end
end
