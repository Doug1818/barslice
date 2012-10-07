class AddClickCountToBars < ActiveRecord::Migration
  def change
    add_column :bars, :click_count, :integer, :default => 0
  end
end
