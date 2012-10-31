class ChangeContentToText < ActiveRecord::Migration
  def up
  	change_column :messages, :content, :text
  end

  def down
  end
end
