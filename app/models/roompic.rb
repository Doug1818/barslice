class Roompic < ActiveRecord::Base
  attr_accessible :description, :pic
  belongs_to :room
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
end
