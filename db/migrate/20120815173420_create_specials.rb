class CreateSpecials < ActiveRecord::Migration
  def change
    create_table :specials do |t|
      t.integer :bar_id
      t.date :start_date
      t.date :end_date
      t.boolean :sunday
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wesnesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.integer :from
      t.integer :until

      t.timestamps
    end
  end
end
