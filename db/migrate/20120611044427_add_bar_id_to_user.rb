class AddBarIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :bar_id, :integer
  end
end
