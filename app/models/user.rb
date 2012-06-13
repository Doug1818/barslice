class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :isbar
  # attr_accessible :title, :body

  before_save { |user| user.email = email.downcase }
  
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, 
  #					format: { with: VALID_EMAIL_REGEX },
  #					uniqueness: { case_sensitive: false }
  #validates :password, length: { minimum: 6 }
  #validates :password_confirmation, presence: true
end