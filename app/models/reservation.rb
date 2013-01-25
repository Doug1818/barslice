class Reservation < ActiveRecord::Base
  attr_accessible :date, :start_time, :end_time, :hdct, :room_id, :bar_response, :user_response, :bar_accepts_date, :bar_rejects_date, :user_accepts_date, :user_rejects_date, :cc_required, :respolicy_accepted, :stripe_card_token, :stripe_card_type, :stripe_card_last4
  attr_accessor :stripe_card_token
  belongs_to :room
  belongs_to :user
  has_many :messages, dependent: :destroy

  scope :of_bar, lambda { |bar| joins(:room).where("rooms.bar_id = ?", bar.id) }
  scope :requested, where(bar_response: nil, user_response: nil).order("created_at desc")
  scope :accepted, where(bar_response: 1, user_response: nil).order("date")
  scope :confirmed, where(bar_response: 1, user_response: 1).order("date")
  scope :future, where("date >= ?", Time.now.to_date)

  validates :date, presence: true
  validates :hdct, presence: true, numericality: { only_integer: true }
  validate  :future_date
  validate  :time_order
  validate  :capacity
  validate  :bar_date_time
  validate  :room_date_time
  validate  :respolicy_is_accepted

  def respolicy_is_accepted
    if self.user_response == 1 && self.respolicy_accepted == false
      self.errors[:reservation_policy] << "must be accepted"
    end
  end

  def future_date
    if self.date != nil && self.date < Time.now.to_date
      self.errors[:date] << "can't be in the past"
    end
  end

  def time_order
    if self.end_time <= self.start_time
      self.errors[:end_time] << "must be later than start time"
    end
  end

  def capacity
  	room = Room.find(self.room_id)
  	x = []
  	x = room.hdctranges.where("hdctranges.min <= ? AND hdctranges.max >= ? 
      AND hdctranges.#{Date::DAYNAMES[date.wday].downcase} = ?", hdct, hdct, true) if hdct.present? && date.present?
  	if x.empty?
  		self.errors[:number_of_people] << "must fall within room minimum / maximum 
  		(check room capacity by clicking on the room profile link above)"
	  end
  end

  def bar_date_time
  	room = Room.find(self.room_id)
  	bar = Bar.find(room.bar_id)
  	x = []
  	x = bar.hrsranges.where("open <= ? AND close >= ? AND hrsranges.#{Date::DAYNAMES[self.date.wday].downcase} = ?", 
  		self.start_time, self.end_time, true) if self.date.present?
  	if x.empty?
  		self.errors[:date_and_time] << "must fall within bar hours (check bar hours by clicking on the bar profile link above)"
	  end
  end

  def room_date_time
  	room = Room.find(self.room_id)
  	
  	bad_time = room.restrictions.where("(before > ? OR after < ?) AND restrictions.#{Date::DAYNAMES[date.wday].downcase} = ?
      AND restrictions.start_date IS NULL AND restrictions.end_date IS NULL", start_time, end_time, true) if date.present?
  	bad_date = room.restrictions.where("restrictions.start_date <= ? AND restrictions.end_date >= ?
      AND restrictions.#{Date::DAYNAMES[date.wday].downcase} = ? AND before IS NULL AND after IS NULL", date, date, true) if date.present?
    bad_date_and_time = room.restrictions.where("(before > ? OR after < ?) AND restrictions.start_date <= ? AND restrictions.end_date >= ?
      AND restrictions.#{Date::DAYNAMES[date.wday].downcase} = ?", start_time, end_time, date, date, true) if date.present?
    bad_day = room.restrictions.where("restrictions.#{Date::DAYNAMES[date.wday].downcase} = ?
      AND restrictions.start_date IS NULL AND restrictions.end_date IS NULL AND before IS NULL AND after IS NULL", true) if date.present?

  	bad_restriction = bad_time + bad_date + bad_date_and_time + bad_day if !bad_time.nil? && 
  		!bad_date.nil? && !bad_date_and_time.nil? && !bad_day.nil?
  	
  	if bad_restriction != nil && bad_restriction.any?
  		self.errors[:date] << "/ time must not fall while room availability is restricted 
  		(check restrictions by clicking on the room profile link above)"
	  end
  end
end
