class AddFieldsToRestrictions < ActiveRecord::Migration
  def change
    add_column :restrictions, :sunday, :boolean
    add_column :restrictions, :monday, :boolean
    add_column :restrictions, :tuesday, :boolean
    add_column :restrictions, :wednesdasy, :boolean
    add_column :restrictions, :thursday, :boolean
    add_column :restrictions, :friday, :boolean
    add_column :restrictions, :saturday, :boolean
    add_column :restrictions, :start_time, :time
    add_column :restrictions, :end_time, :time
  end
end
