class AddRefundedDateToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :refunded_date, :date
  end
end
