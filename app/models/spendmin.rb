class Spendmin < ActiveRecord::Base
  attr_accessible :friday, :min, :monday, :per_person, :saturday, :sunday, :thursday, :tuesday, :var_by_day, :wednesday
  belongs_to :room
end
