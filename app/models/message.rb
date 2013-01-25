class Message < ActiveRecord::Base
  attr_accessible :content, :sent_by, :reservation_id, :attachment
  belongs_to :reservation
  belongs_to :bar
  belongs_to :user
  has_attached_file :attachment, 
  					storage: :s3,
  					s3_credentials: { 
              access_key_id: ENV['S3_ID'], 
              secret_access_key: ENV['S3_SECRET'], 
              bucket: ENV['S3_BUCKET'] },
  					path: "files/:id/:filename"

  validates_attachment_size :attachment, less_than: 5.megabytes
  validates :content, presence: true
end