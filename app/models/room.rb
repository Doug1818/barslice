class Room < ActiveRecord::Base
  attr_accessible :name, :privacy, :description, :hdctranges_attributes, :fees_attributes, 
  	:spendmins_attributes, :restrictions_attributes, :roompics_attributes
  belongs_to :bar
  has_many :hdctranges, dependent: :destroy
  has_many :fees, dependent: :destroy
  has_many :spendmins, dependent: :destroy
  has_many :roompics, dependent: :destroy
  has_many :restrictions, dependent: :destroy
  accepts_nested_attributes_for :hdctranges, :fees, :spendmins, :roompics, :restrictions, allow_destroy: true

  validates :name, presence: true, length: { maximum: 50 }
  validates :privacy, presence: true
  validates :description, presence: true
  validate  :hdct_week_days


  def hdct_week_days
  	count = []
  	self.hdctranges.each_with_index do |hdctrange, idx|
		hdctrange.sunday ? sun = 1 : sun = 0
		hdctrange.monday ? mon = 1 : mon = 0
		hdctrange.tuesday ? tues = 1 : tues = 0
		hdctrange.wednesday ? wed = 1 : wed = 0
		hdctrange.thursday ? thurs = 1 : thurs = 0
		hdctrange.friday ? fri = 1 : fri = 0
		hdctrange.saturday ? sat = 1 : sat = 0
		count[idx] = sun + mon + tues + wed + thurs + fri + sat
	end
  	if count.inject(:+) != 7 && count.inject(:+) != 0
  	  self.errors[:each_weekday] << "for Number of people must be selected once."
  	end
  end
end
