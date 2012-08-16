class AddNameToSpecials < ActiveRecord::Migration
  def change
    add_column :specials, :name, :string
  end
end
