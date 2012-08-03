class AddWebsiteToBars < ActiveRecord::Migration
  def change
    add_column :bars, :website, :string
  end
end
