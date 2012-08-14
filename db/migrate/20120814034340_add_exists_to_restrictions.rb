class AddExistsToRestrictions < ActiveRecord::Migration
  def change
    add_column :restrictions, :exists, :integer
  end
end
