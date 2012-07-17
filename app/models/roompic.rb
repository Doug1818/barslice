class Roompic < ActiveRecord::Base
  attr_accessible :description, :pic
  belongs_to :room
  has_attached_file :pic, styles: { medium: "300x300>", thumb: "100x100>" },
  					storage: :s3,
  					s3_credentials: "#{Rails.root}/config/s3.yml",
  					path: ":style/:filename"

  validates_attachment_presence :pic
  validates_attachment_size :pic, less_than: 5.megabytes
end
