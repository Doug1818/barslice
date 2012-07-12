class Room < ActiveRecord::Base
  attr_accessible :bar_id, :description, :max_head_count, :min_head_count, :min_spend, :name, :per_person, :privacy
end
