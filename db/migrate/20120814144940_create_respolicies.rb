class CreateRespolicies < ActiveRecord::Migration
  def change
    create_table :respolicies do |t|
      t.integer :bar_id
      t.text :description

      t.timestamps
    end
  end
end
