class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :phone, :reservations_attributes
  # attr_accessible :title, :body

  has_many :reservations, dependent: :destroy
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :reservations, allow_destroy: true

  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, 
  #					format: { with: VALID_EMAIL_REGEX },
  #					uniqueness: { case_sensitive: false }
  #validates :password, length: { minimum: 6 }
  #validates :password_confirmation, presence: true
end
