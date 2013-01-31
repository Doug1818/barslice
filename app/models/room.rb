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
  validate  :name_uniqueness, on: :create #need to add different validation for update action
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
  	hdct_days = []
  	self.hdctranges.each_with_index do |hdctrange, idx|
  		hdctrange.sunday ?    sun = 1 : sun = 0
  		hdctrange.monday ?    mon = 1 : mon = 0
  		hdctrange.tuesday ?   tue = 1 : tue = 0
  		hdctrange.wednesday ? wed = 1 : wed = 0
  		hdctrange.thursday ?  thu = 1 : thu = 0
  		hdctrange.friday ?    fri = 1 : fri = 0
  		hdctrange.saturday ?  sat = 1 : sat = 0
  		hdct_days[idx] = sun + mon + tue + wed + thu + fri + sat
    end
  	
    closed_days = []
    Bar.find(self.bar_id).hrsranges.each_with_index do |hrsrange, idx|
      if hrsrange.closed
        hrsrange.sunday ?    sun = 1 : sun = 0
        hrsrange.monday ?    mon = 1 : mon = 0
        hrsrange.tuesday ?   tue = 1 : tue = 0
        hrsrange.wednesday ? wed = 1 : wed = 0
        hrsrange.thursday ?  thu = 1 : thu = 0
        hrsrange.friday ?    fri = 1 : fri = 0
        hrsrange.saturday ?  sat = 1 : sat = 0
        closed_days[idx] = sun + mon + tue + wed + thu + fri + sat
      else
        closed_days[idx] = 0
      end
    end
    
    if hdct_days.inject(:+) != 7 && hdct_days.inject(:+) != 0 && hdct_days.inject(:+) != ( 7 - closed_days.inject(:+) )
  	  self.errors[:each_weekday] << "for Number of people must be selected once"
  	end
  end
end
