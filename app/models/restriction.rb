class Restriction < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :before, :after, :friday, :monday, :saturday, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :room
end
