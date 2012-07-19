class Fee < ActiveRecord::Base
  attr_accessible :fee, :friday, :monday, :saturday, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :room
end
