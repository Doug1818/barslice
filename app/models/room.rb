class Room < ActiveRecord::Base
  attr_accessible :restrictions_attributes, :name, :description, :max_head_count, :min_head_count, :min_spend, 
  	:per_person, :privacy
  belongs_to :bar
  has_many :restrictions
  accepts_nested_attributes_for :restrictions, allow_destroy: true
end
