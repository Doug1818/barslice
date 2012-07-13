class Restriction < ActiveRecord::Base
  attr_accessible :end, :start
  belongs_to :room
end
