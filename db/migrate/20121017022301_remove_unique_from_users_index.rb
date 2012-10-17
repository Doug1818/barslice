class RemoveUniqueFromUsersIndex < ActiveRecord::Migration
  def up
  	remove_index :users, :name => 'index_users_on_email'
  	add_index :users, :email
  end

  def down
  end
end
