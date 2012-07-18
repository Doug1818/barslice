class CreateSpendmins < ActiveRecord::Migration
  def change
    create_table :spendmins do |t|
      t.integer :room_id
      t.integer :min
      t.boolean :per_person
      t.boolean :var_by_day
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday

      t.timestamps
    end
  end
end
