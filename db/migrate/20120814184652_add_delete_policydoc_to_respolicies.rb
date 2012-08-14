class AddDeletePolicydocToRespolicies < ActiveRecord::Migration
  def change
    add_column :respolicies, :delete_policydoc, :integer
  end
end
