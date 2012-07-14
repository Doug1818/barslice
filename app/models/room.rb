class Room < ActiveRecord::Base
  attr_accessible :description, :max_head_count, :min_head_count, :min_spend, :name, :per_person, :privacy, :mon1, :mon2
  belongs_to :bar
  has_many :restrictions
end
