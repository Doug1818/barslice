class AddClosedToHrsranges < ActiveRecord::Migration
  def change
    add_column :hrsranges, :closed, :boolean
  end
end
