class AddIsbarToUser < ActiveRecord::Migration
  def change
    add_column :users, :isbar, :boolean
  end
end
