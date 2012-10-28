class Reservation < ActiveRecord::Base
  attr_accessible :date, :email, :end_time, :hdct, :name, :phone, :start_time, :room_id, :bar_response, :user_response
  belongs_to :room
  belongs_to :user

  scope :of_bar, lambda { |bar| joins(:room).where("rooms.bar_id = ?", bar.id) }
  scope :requested, where(bar_response: nil).order("created_at desc")
  scope :accepted, where(bar_response: 1, user_response: nil).order("date")
  scope :confirmed, where(bar_response: 1, user_response: 1).order("date")

end
