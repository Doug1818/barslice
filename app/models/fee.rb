class Fee < ActiveRecord::Base
  attr_accessible :amount, :friday, :monday, :saturday, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :room
end
