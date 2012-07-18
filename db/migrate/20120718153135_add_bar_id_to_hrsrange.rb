class AddBarIdToHrsrange < ActiveRecord::Migration
  def change
    add_column :hrsranges, :bar_id, :integer
  end
end
