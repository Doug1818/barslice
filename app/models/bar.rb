class Bar < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  attr_accessible :name, :address, :neighborhood, :phone, :website, :hrsranges_attributes, :click_count

  has_many :rooms, dependent: :destroy
  has_many :hrsranges, dependent: :destroy
  accepts_nested_attributes_for :hrsranges, allow_destroy: true
  has_one  :respolicy, dependent: :destroy
  has_many :specials, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :address, presence: true, length: { maximum: 150 }
  validates :neighborhood, presence: true
  validates :phone, presence: true
  validates :website, presence: true
  validate  :phone_length
  validate  :week_days

  def phone_length
    if !self.phone.blank? && self.phone.length != 10
      self.errors[:phone_number] = "must be 10 digits"
    end
  end

  def week_days
    count = []
      self.hrsranges.each_with_index do |hrsrange, idx|
      hrsrange.sunday ?    sun = 1   : sun = 0
      hrsrange.monday ?    mon = 1   : mon = 0
      hrsrange.tuesday ?   tues = 1  : tues = 0
      hrsrange.wednesday ? wed = 1   : wed = 0
      hrsrange.thursday ?  thurs = 1 : thurs = 0
      hrsrange.friday ?    fri = 1   : fri = 0
      hrsrange.saturday ?  sat = 1   : sat = 0
      count[idx] = sun + mon + tues + wed + thurs + fri + sat
    end
    if count.inject(:+) != 7 && count.inject(:+) != 0
      self.errors[:each_weekday] << "for Hours of operation must be selected once"
    end
  end

  NEIGHBORHOODS = ["Alphabet City", "Battery Park", "Chelsea", 
  	"Chinatown", "Civic Center", "East Harlem", "East Village", 
  	"Financial District", "Flatiron", "Gramercy", "Greenwich Village", 
  	"Harlem", "Hell's Kitchen", "Inwood", "Kips Bay", "Koreatown", 
  	"Little Italy", "Lower East Side", "Manhattan Valley", 
  	"Marble Hill", "Meatpacking District", "Midtown East", 
  	"Midtown West", "Morningside Heights", "Murray Hill", "NoHo", 
  	"Nolita", "Roosevelt Island", "SoHo", "South Street Seaport", 
  	"South Village", "Stuyvesant Town", "Theater District", 
  	"TriBeCa", "Two Bridges", "Union Square", "Upper East Side", 
  	"Upper West Side", "Washington Heights", "West Village", "Yorkville"]
end
