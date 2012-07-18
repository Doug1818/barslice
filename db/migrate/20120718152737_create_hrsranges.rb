class CreateHrsranges < ActiveRecord::Migration
  def change
    create_table :hrsranges do |t|
      t.time :start
      t.time :end
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
