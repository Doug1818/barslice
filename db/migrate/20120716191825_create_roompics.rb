class CreateRoompics < ActiveRecord::Migration
  def change
    create_table :roompics do |t|
      t.string :description
      t.integer :room_id

      t.timestamps
    end
  end
end
