class Bar < ActiveRecord::Base
  attr_accessible :address, :email, :name, :neighborhood, :phone

  before_save { |bar| bar.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }

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
