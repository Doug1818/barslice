#encoding: utf-8
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
  validate  :room_selected
  validate  :special_separator

  def self.filtered(reservation)
    specials = []
    good_time = where("specials.from <= ? AND specials.until >= ? AND specials.#{Date::DAYNAMES[reservation.date.wday].downcase} = ?
      AND specials.start_date IS NULL AND specials.end_date IS NULL", reservation.start_time, reservation.end_time, true)
    good_date = where("specials.start_date <= ? AND specials.end_date >= ?
      AND specials.#{Date::DAYNAMES[reservation.date.wday].downcase} = ? AND specials.from IS NULL AND specials.until IS NULL", reservation.date, reservation.date, true)
    good_date_and_time = where("specials.from <= ? AND specials.until >= ? AND specials.start_date <= ? AND specials.end_date >= ?
      AND specials.#{Date::DAYNAMES[reservation.date.wday].downcase} = ?", reservation.start_time, reservation.end_time, reservation.date, reservation.date, true)
    good_day = where("specials.#{Date::DAYNAMES[reservation.date.wday].downcase} = ?
      AND specials.start_date IS NULL AND specials.end_date IS NULL AND specials.from IS NULL AND specials.until IS NULL", true)
    specials = good_time + good_date + good_date_and_time + good_day if !good_time.nil? && !good_date.nil? && !good_date_and_time.nil? && !good_day.nil?
    specials = specials.to_a.uniq if specials.any?
    specials
  end
  
  def room_selected
    if !self.rooms.any?
      self.errors[:applicable_rooms] = "must have at least one room selected"
    end
  end

  def special_separator
    if self.name.include?("•")
      self.errors[:special_name] = "cannot include the character '•', because it is used to separate specials in some places on the site"
    end
  end
end
