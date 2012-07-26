class Hrsrange < ActiveRecord::Base
  attr_accessible :close, :friday, :monday, :saturday, :open, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :bar
end
