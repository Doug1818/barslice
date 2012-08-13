class AddOptionalFiltersToSearches < ActiveRecord::Migration
  def change
  	add_column :searches, :no_fee, :boolean
  	add_column :searches, :no_spendmin, :boolean
  end
end
