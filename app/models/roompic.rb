class Roompic < ActiveRecord::Base
  attr_accessible :description, :pic
  belongs_to :room
  has_attached_file :pic, styles: { 
  						   thumb:  { geometry: "100x100>", convert_options: "-auto-orient" }, 
  						   medium: { geometry: "300x300>", convert_options: "-auto-orient" }, 
  						   large:  { geometry: "600x600>", convert_options: "-auto-orient" } },
  					storage: :s3,
  					s3_credentials: "#{Rails.root}/config/s3.yml",
  					path: ":style/:id/:filename"

  validates_attachment_presence :pic
  validates_attachment_size :pic, less_than: 5.megabytes
end
