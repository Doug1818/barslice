class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.date :date
      t.integer :start_time
      t.integer :end_time
      t.integer :hdct

      t.timestamps
    end
  end
end
