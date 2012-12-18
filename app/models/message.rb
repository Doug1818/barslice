class Message < ActiveRecord::Base
  attr_accessible :content, :sent_by, :reservation_id, :attachment
  belongs_to :reservation
  belongs_to :bar
  belongs_to :user
  has_attached_file :attachment, 
  					storage: :s3,
  					s3_credentials: "#{Rails.root}/config/s3.yml",
  					path: "files/:id/:filename"

  validates_attachment_size :attachment, less_than: 5.megabytes
  validates :content, presence: true
end
