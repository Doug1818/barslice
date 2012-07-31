class Spendmin < ActiveRecord::Base
  attr_accessible :friday, :min, :monday, :per_person, :saturday, :sunday, :thursday, :tuesday, :var_by_day, :wednesday
  belongs_to :room

  before_save do |spendmin|
  	if spendmin.min? && !spendmin.sunday && !spendmin.monday && !spendmin.tuesday && !spendmin.wednesday && !spendmin.thursday && !spendmin.friday && !spendmin.saturday
  		spendmin.sunday = true && spendmin.monday = true && spendmin.tuesday = true && spendmin.wednesday = true && spendmin.thursday = true && spendmin.friday = true && spendmin.saturday = true
	end
  end
end
