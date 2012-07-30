class Room < ActiveRecord::Base
  attr_accessible :name, :privacy, :description, :hdctranges_attributes, :fees_attributes, 
  	:spendmins_attributes, :restrictions_attributes, :roompics_attributes
  belongs_to :bar
  has_many :hdctranges, dependent: :destroy
  has_many :fees, dependent: :destroy
  has_many :spendmins, dependent: :destroy
  has_many :roompics, dependent: :destroy
  has_many :restrictions, dependent: :destroy
  accepts_nested_attributes_for :hdctranges, :fees, :spendmins, :roompics, :restrictions, allow_destroy: true
end
