class AddAttributesToBars < ActiveRecord::Migration
  def change
    add_column :bars, :name, :string
    add_column :bars, :address, :string
    add_column :bars, :neighborhood, :string
    add_column :bars, :phone, :string
  end
end
