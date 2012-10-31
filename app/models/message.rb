class Message < ActiveRecord::Base
  attr_accessible :content, :sent_by, :reservation_id
  belongs_to :reservation
  belongs_to :bar
  belongs_to :user

  validates :content, presence: true
end
