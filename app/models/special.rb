class Special < ActiveRecord::Base
  attr_accessible :name, :end_date, :friday, :from, :monday, :saturday, :start_date, :sunday, :thursday, :tuesday,
   :until, :wednesday, :description, :min_hdct, :open_bar, :food, :room_ids
  
  belongs_to :bar
  has_many :rmsprelationships, dependent: :destroy
  has_many :rooms, through: :rmsprelationships

  # Set all weekday booleans to true if no valid period is selected
  before_save do |special|
  	if !special.sunday && !special.monday && !special.tuesday && !special.wednesday && !special.thursday && !special.friday && !special.saturday
		  special.sunday = true && special.monday = true && special.tuesday = true && special.wednesday = true && special.thursday = true && special.friday = true && special.saturday = true
    end
  end

  validates :name, presence: true, length: { maximum: 80 }
  validates :description, presence: true
  validate  :room_selected

  def room_selected
    if !self.rooms.any?
      self.errors[:applicable_rooms] = "must have at least one room selected (otherwise go to your home page to delete the special)."
    end
  end
end
