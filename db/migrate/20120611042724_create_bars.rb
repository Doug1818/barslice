class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :phone

      t.timestamps
    end
  end
end
