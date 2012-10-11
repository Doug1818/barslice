class Reservation < ActiveRecord::Base
  attr_accessible :date, :email, :end_time, :hdct, :name, :phone, :start_time, :room_id
  belongs_to :room
  belongs_to :user
end
