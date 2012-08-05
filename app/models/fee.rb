class Fee < ActiveRecord::Base
  attr_accessible :amount, :friday, :monday, :saturday, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :room

  before_save do |fee|
  	if fee.amount? && !fee.sunday && !fee.monday && !fee.tuesday && !fee.wednesday && !fee.thursday && !fee.friday && !fee.saturday
  		fee.sunday = true && fee.monday = true && fee.tuesday = true && fee.wednesday = true && fee.thursday = true && fee.friday = true && fee.saturday = true
	end
  end

  validates :amount, :numericality => { :only_integer => true }, allow_blank: true
end
