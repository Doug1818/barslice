class Bar < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  attr_accessible :name, :address, :neighborhood, :phone

  has_many :rooms, foreign_key: "bar_id"

  before_save { |bar| bar.phone = phone.gsub(/\D/, '') }

  validates :name, presence: true, length: { maximum: 100 }
  validates :address, presence: true, length: { maximum: 150 }
  validates :neighborhood, presence: true # add list validation
  validates :phone, presence: true#,
                    #length: { minimum: 10 },
                    #length: { maximum: 10 }

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
