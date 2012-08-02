class Search < ActiveRecord::Base
  attr_accessible :bar_name, :date, :hdct, :location, :privacy, :start_time, :end_time

  def rooms
  	@rooms ||= find_rooms
  end

private
  def find_rooms
  	rooms = Room.order(privacy)
  	rooms = rooms.joins(:bar).where("neighborhood = ?", location) if location.present?
  	rooms = rooms.joins(:bar).where("bars.name = ?", bar_name) if bar_name.present?
  	rooms = rooms.joins(:hdctranges).where("min <= ? AND max >= ? AND hdctranges.#{Date::DAYNAMES[date.wday].downcase} = ?", hdct, hdct, true) if hdct.present?
    rooms = rooms.where("privacy = ?", privacy) if privacy.present?
    rooms = rooms.joins(:bar).joins(:bar => :hrsranges).where("open <= ? AND close >= ? AND hrsranges.#{Date::DAYNAMES[date.wday].downcase} = ?", 
      start_time, end_time, true)
  
    bad_time = rooms.joins(:restrictions).where("(before > ? OR after < ?) AND restrictions.#{Date::DAYNAMES[date.wday].downcase} = ? 
      AND start_date IS NULL AND end_date IS NULL", start_time, end_time, true)
    bad_date = rooms.joins(:restrictions).where("start_date <= ? AND end_date >= ? AND restrictions.#{Date::DAYNAMES[date.wday].downcase} = ? 
      AND before IS NULL AND after IS NULL", date, date, true)
    bad_date_and_time = rooms.joins(:restrictions).where("(before > ? OR after < ?) AND start_date <= ? AND end_date >= ? 
      AND restrictions.#{Date::DAYNAMES[date.wday].downcase} = ?", start_time, end_time, date, date, true)
    bad_day = rooms.joins(:restrictions).where("restrictions.#{Date::DAYNAMES[date.wday].downcase} = ? AND start_date IS NULL AND end_date IS NULL 
      AND before IS NULL AND after IS NULL", true)
    
    bad_rooms = bad_time + bad_date + bad_date_and_time + bad_day
    
    bad_rooms.each do |bad_room|
      rooms.delete_if { |room| room == bad_room }
    end
    
    rooms
  end
end
