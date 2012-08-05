class Spendmin < ActiveRecord::Base
  attr_accessible :friday, :min, :monday, :per_person, :saturday, :sunday, :thursday, :tuesday, :var_by_day, :wednesday
  belongs_to :room

  before_save do |spendmin|
  	if spendmin.min? && !spendmin.sunday && !spendmin.monday && !spendmin.tuesday && !spendmin.wednesday && !spendmin.thursday && !spendmin.friday && !spendmin.saturday
  		spendmin.sunday = true && spendmin.monday = true && spendmin.tuesday = true && spendmin.wednesday = true && spendmin.thursday = true && spendmin.friday = true && spendmin.saturday = true
	end
  end

  validates :min, :numericality => { :only_integer => true }, allow_blank: true
  validate :total_or_per_person

  def total_or_per_person
  	if self.min && !self.per_person
  		self.errors[""] << "choice of total or per person can't be blank"
	end
  end
end
