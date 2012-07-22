class Restriction < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :start_time, :end_time, :friday, :monday, :saturday, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :room
end
