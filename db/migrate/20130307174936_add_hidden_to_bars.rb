class AddHiddenToBars < ActiveRecord::Migration
  def change
    add_column :bars, :hidden, :boolean, :default => false
  end
end
