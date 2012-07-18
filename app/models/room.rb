class Room < ActiveRecord::Base
  attr_accessible :restrictions_attributes, :roompics_attributes, :name, :description, :max_head_count, :min_head_count, :min_spend, 
  	:per_person, :privacy, :mon1, :mon1ap, :mon2, :mon2ap, :tues1, :tues1ap, :tues2, :tues2ap, :wed1, :wed1ap, 
  	:wed2, :wed2ap, :thurs1, :thurs1ap, :thurs2, :thurs2ap, :fri1, :fri1ap, :fri2, :fri2ap, :sat1, :sat1ap, 
  	:sat2, :sat2ap, :sun1, :sun1ap, :sun2, :sun2ap
  belongs_to :bar
  has_many :roompics
  has_many :restrictions
  accepts_nested_attributes_for :roompics, :restrictions, allow_destroy: true
  has_many :hdctranges
  has_many :spendmins
end
