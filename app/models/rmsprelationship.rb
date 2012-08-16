class Rmsprelationship < ActiveRecord::Base
  attr_accessible :room_id

  belongs_to :room
  belongs_to :special
end
