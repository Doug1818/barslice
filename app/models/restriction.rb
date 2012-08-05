class Restriction < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :before, :after, :friday, :monday, :saturday, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :room

  before_save do |restriction|
  	if (restriction.start_date? || restriction.end_date? || restriction.before? || restriction.after?) && !restriction.sunday && !restriction.monday && !restriction.tuesday && !restriction.wednesday && !restriction.thursday && !restriction.friday && !restriction.saturday
  		restriction.sunday = true && restriction.monday = true && restriction.tuesday = true && restriction.wednesday = true && restriction.thursday = true && restriction.friday = true && restriction.saturday = true
	end
  end

  validate :date_order
  validate :both_dates
  validate :time_order

  def date_order
  	if self.start_date && self.end_date && (self.start_date > self.end_date)
  	  self.errors[""] << "end date must be after or equivalent to start date"
  	end
  end

  def both_dates
  	if (self.start_date && !self.end_date) || (self.end_date && !self.start_date)
  	  self.errors[""] << "start date and end date both need to be present. Set them both to the same date if restriction is for a single day"
  	end
  end

  def time_order
  	if self.before && self.after && (self.after <= self.before)
  	  self.errors[""] << "after time must be later than before time"
  	end
  end
end
