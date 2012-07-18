class CreateHdctranges < ActiveRecord::Migration
  def change
    create_table :hdctranges do |t|
      t.integer :room_id
      t.integer :min
      t.integer :max
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
