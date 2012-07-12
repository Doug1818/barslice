class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :bar_id
      t.string :name
      t.integer :privacy
      t.integer :min_head_count
      t.integer :max_head_count
      t.text :description
      t.integer :min_spend
      t.boolean :per_person

      t.timestamps
    end
  end
end
