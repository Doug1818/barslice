class Charge < ActiveRecord::Base
  attr_accessible :amount, :direct_to_bar, :reason, :reservation_id, :user_id, :refunded, :refunded_date

  belongs_to :bar
  belongs_to :user
  belongs_to :reservation

  REASONS = ["Reservation fee", "Cancellation policy violation"]
end
