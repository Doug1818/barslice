class CreateRmsprelationships < ActiveRecord::Migration
  def change
    create_table :rmsprelationships do |t|
      t.integer :room_id
      t.integer :special_id

      t.timestamps
    end
  end
end
