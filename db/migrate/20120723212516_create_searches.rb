class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :location
      t.string :bar_name
      t.date :date
      t.time :time
      t.integer :hdct
      t.integer :privacy

      t.timestamps
    end
  end
end
