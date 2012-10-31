class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :user_id
      t.integer :bar_id
      t.integer :reservation_id
      t.boolean :sent_by

      t.timestamps
    end
  end
end
