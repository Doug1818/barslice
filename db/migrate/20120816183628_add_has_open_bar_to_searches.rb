class AddHasOpenBarToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :has_open_bar, :boolean
  end
end
