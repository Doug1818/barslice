class Hrsrange < ActiveRecord::Base
  attr_accessible :close, :friday, :monday, :saturday, :open, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :bar

  before_save do |hrsrange|
  	if hrsrange.open? && hrsrange.close? && !hrsrange.sunday && !hrsrange.monday && !hrsrange.tuesday && !hrsrange.wednesday && !hrsrange.thursday && !hrsrange.friday && !hrsrange.saturday
  		hrsrange.sunday = true && hrsrange.monday = true && hrsrange.tuesday = true && hrsrange.wednesday = true && hrsrange.thursday = true && hrsrange.friday = true && hrsrange.saturday = true
	end
  end
end
