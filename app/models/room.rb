class Room < ActiveRecord::Base
  attr_accessible :name, :privacy, :description, :hdctranges_attributes, :fees_attributes, 
  	:spendmins_attributes, :restrictions_attributes, :roompics_attributes
  belongs_to :bar
  has_many :hdctranges
  has_many :fees
  has_many :spendmins
  has_many :roompics
  has_many :restrictions
  accepts_nested_attributes_for :hdctranges, :fees, :spendmins, :roompics, :restrictions, allow_destroy: true
end
