class Search < ActiveRecord::Base
  attr_accessible :bar_name, :date, :hdct, :location, :privacy, :start_time, :end_time, :no_fee, :no_spendmin

  validates :date, presence: true
  validates :hdct, numericality: { only_integer: true }, allow_blank: true
  validate  :future_date
  validate  :time_order
  
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

  def rooms
  	@rooms ||= find_rooms
  end

private
  def find_rooms
  	rooms = Room.order(privacy)
  	rooms = rooms.joins(:bar).where("neighborhood = ?", location) if location.present?
  	rooms = rooms.joins(:bar).where("bars.name = ?", bar_name) if bar_name.present?
  	rooms = rooms.joins(:bar).joins(:bar => :hrsranges).where("open <= ? AND close >= ? AND hrsranges.#{Date::DAYNAMES[date.wday].downcase} = ?", 
      start_time, end_time, true) if date.present?
    rooms = rooms.joins(:hdctranges).where("min <= ? AND max >= ? AND hdctranges.#{Date::DAYNAMES[date.wday].downcase} = ?", 
      hdct, hdct, true) if hdct.present? && date.present?
    rooms = rooms.where("privacy = ?", privacy) if privacy.present? && date.present?
    rooms = rooms.joins(:fees).where("amount IS NULL") if no_fee.present?
    rooms = rooms.joins(:spendmins).where("min IS NULL") if no_spendmin.present?
  
    bad_time = rooms.joins(:restrictions).where("(before > ? OR after < ?) AND restrictions.#{Date::DAYNAMES[date.wday].downcase} = ? 
      AND start_date IS NULL AND end_date IS NULL", start_time, end_time, true) if date.present?
    bad_date = rooms.joins(:restrictions).where("start_date <= ? AND end_date >= ? AND restrictions.#{Date::DAYNAMES[date.wday].downcase} = ? 
      AND before IS NULL AND after IS NULL", date, date, true) if date.present?
    bad_date_and_time = rooms.joins(:restrictions).where("(before > ? OR after < ?) AND start_date <= ? AND end_date >= ? 
      AND restrictions.#{Date::DAYNAMES[date.wday].downcase} = ?", start_time, end_time, date, date, true) if date.present?
    bad_day = rooms.joins(:restrictions).where("restrictions.#{Date::DAYNAMES[date.wday].downcase} = ? AND start_date IS NULL AND end_date IS NULL 
      AND before IS NULL AND after IS NULL", true) if date.present?
    
    bad_rooms = bad_time + bad_date + bad_date_and_time + bad_day if !bad_time.nil? && !bad_date.nil? && !bad_date_and_time.nil? && !bad_day.nil?
    
    bad_rooms.each do |bad_room|
      rooms.delete_if { |room| room == bad_room }
    end if !bad_rooms.nil?
    
    rooms
  end
end
