class Roompic < ActiveRecord::Base
  attr_accessible :description, :pic
  belongs_to :room
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
