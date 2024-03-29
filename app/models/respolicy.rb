class Respolicy < ActiveRecord::Base
  attr_accessible :description, :policydoc, :delete_policydoc
  belongs_to :bar
  has_attached_file :policydoc,
  					storage: :s3,
  					s3_credentials: { 
              access_key_id: ENV['S3_ID'], 
              secret_access_key: ENV['S3_SECRET'], 
              bucket: ENV['S3_BUCKET'] },
  					path: ":id/:filename"

  before_save :destroy_policydoc?

  def delete_policydoc
    @delete_policydoc ||= "0"
  end

  def delete_policydoc=(value)
    @delete_policydoc = value
  end

private
  def destroy_policydoc?
    self.policydoc.clear if @delete_policydoc == "1"
  end

  validates_attachment_size :policydoc, less_than: 5.megabytes
end
