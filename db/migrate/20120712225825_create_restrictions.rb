class CreateRestrictions < ActiveRecord::Migration
  def change
    create_table :restrictions do |t|
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
