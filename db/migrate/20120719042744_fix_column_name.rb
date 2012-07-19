class FixColumnName < ActiveRecord::Migration
  def up
  	rename_column :fees, :fee, :amount
  end

  def down
  end
end
