class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.integer :room_id
      t.integer :fee
      t.boolean :sunday
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday

      t.timestamps
    end
  end
end
