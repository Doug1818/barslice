class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :amount
      t.integer :bar_id
      t.integer :reservation_id
      t.integer :user_id
      t.boolean :direct_to_bar
      t.string :reason

      t.timestamps
    end
  end
end
