class Hrsrange < ActiveRecord::Base
  attr_accessible :end, :friday, :monday, :saturday, :start, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :bar
end
