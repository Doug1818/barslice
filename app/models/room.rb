class Room < ActiveRecord::Base
  attr_accessible :name, :privacy, :description, :hdctranges_attributes, :fees_attributes, 
  	:spendmins_attributes, :restrictions_attributes, :roompics_attributes
  belongs_to :bar
  has_many :hdctranges, dependent: :destroy
  has_many :fees, dependent: :destroy
  has_many :spendmins, dependent: :destroy
  has_many :roompics, dependent: :destroy
  has_many :restrictions, dependent: :destroy
  accepts_nested_attributes_for :hdctranges, :fees, :spendmins, :restrictions, :roompics, allow_destroy: true
  has_many :rmsprelationships, dependent: :destroy
  has_many :specials, through: :rmsprelationships
  has_many :reservations, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validate :name_uniqueness, on: :create #need to add different validation for update action
  validates :privacy, presence: true
  validates :description, presence: true
  validate  :week_days

  def name_uniqueness
    names = []
    Bar.find(self.bar_id).rooms.each_with_index { |room, idx| names[idx] = room.name }
    if names.each.include?(self.name)
      self.errors[:room_name] << "is already taken"
    end
  end

  def week_days
  	count = []
  	self.hdctranges.each_with_index do |hdctrange, idx|
  		hdctrange.sunday ?    sun = 1   : sun = 0
  		hdctrange.monday ?    mon = 1   : mon = 0
  		hdctrange.tuesday ?   tues = 1  : tues = 0
  		hdctrange.wednesday ? wed = 1   : wed = 0
  		hdctrange.thursday ?  thurs = 1 : thurs = 0
  		hdctrange.friday ?    fri = 1   : fri = 0
  		hdctrange.saturday ?  sat = 1   : sat = 0
  		count[idx] = sun + mon + tues + wed + thurs + fri + sat
    end
  	
    x = []
    Bar.find(self.bar_id).hrsranges.each { |h| x.push(1) if h.closed }

    if count.inject(:+) != 7 && count.inject(:+) != 0 && count.inject(:+) != x.inject(:+)
  	  self.errors[:each_weekday] << "for Number of people must be selected once"
  	end
  end
end
