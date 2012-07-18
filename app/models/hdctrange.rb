class Hdctrange < ActiveRecord::Base
  attr_accessible :friday, :max, :min, :monday, :saturday, :sunday, :thursday, :tuesday, :var_by_day, :wednesday
  belongs_to :room
end
