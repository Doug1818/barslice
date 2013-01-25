class Roompic < ActiveRecord::Base
  attr_accessible :description, :pic
  belongs_to :room
  has_attached_file :pic, styles: { 
  						   thumb:  { geometry: "100x100>", convert_options: "-auto-orient" }, 
  						   medium: { geometry: "500x500>", convert_options: "-auto-orient" }, 
  						   large:  { geometry: "900x900>", convert_options: "-auto-orient" } },
  					storage: :s3,
  					s3_credentials: { 
              access_key_id: ENV['S3_ID'], 
              secret_access_key: ENV['S3_SECRET'], 
              bucket: ENV['S3_BUCKET'] },
  					path: ":style/:id/:filename"

  #validates_attachment_presence :pic
  validates_attachment_size :pic, less_than: 5.megabytes
end
