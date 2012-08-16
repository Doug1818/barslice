class AddFieldsToSpecials < ActiveRecord::Migration
  def change
  	add_column :specials, :description, :text
  	add_column :specials, :min_hdct, :integer
  	add_column :specials, :open_bar, :boolean
  	add_column :specials, :food, :boolean
  end
end
