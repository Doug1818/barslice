class Hdctrange < ActiveRecord::Base
  attr_accessible :friday, :max, :min, :monday, :saturday, :sunday, :thursday, :tuesday, :var_by_day, :wednesday
  belongs_to :room

  before_save do |hdctrange|
  	if hdctrange.min != nil && hdctrange.max != nil && !hdctrange.sunday && !hdctrange.monday && !hdctrange.tuesday && !hdctrange.wednesday && !hdctrange.thursday && !hdctrange.friday && !hdctrange.saturday
  		hdctrange.sunday = true && hdctrange.monday = true && hdctrange.tuesday = true && hdctrange.wednesday = true && hdctrange.thursday = true && hdctrange.friday = true && hdctrange.saturday = true
	end
  end

  validates :min, presence: true, :numericality => { :only_integer => true }
  validates :max, presence: true, :numericality => { :only_integer => true }
end
