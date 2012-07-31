class Restriction < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :before, :after, :friday, :monday, :saturday, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :room

  before_save do |restriction|
  	if (restriction.start_date? || restriction.end_date? || restriction.before? || restriction.after?) && !restriction.sunday && !restriction.monday && !restriction.tuesday && !restriction.wednesday && !restriction.thursday && !restriction.friday && !restriction.saturday
  		restriction.sunday = true && restriction.monday = true && restriction.tuesday = true && restriction.wednesday = true && restriction.thursday = true && restriction.friday = true && restriction.saturday = true
	end
  end
end
