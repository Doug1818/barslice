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
  	rooms = rooms.joins(:hdctranges).where("min <= ? AND max>= ? AND hdctranges.#{Date::DAYNAMES[date.wday].downcase} = ?", hdct, hdct, true) if hdct.present?
    rooms = rooms.where("privacy = ?", privacy) if privacy.present?
  	rooms = rooms.joins(:bar).joins(:bar => :hrsranges).where("open <= ? AND close >= ? AND hrsranges.#{Date::DAYNAMES[date.wday].downcase} = ?", start_time, end_time, true)
    
    #rooms = rooms.joins(:restrictions).where("after >= ? AND before <= ? AND restrictions.#{Date::DAYNAMES[date.wday].downcase} = ?", end_time, start_time, true)
    #rooms = rooms.joins(:restrictions).where("after >= ? AND restrictions.#{Date::DAYNAMES[date.wday].downcase} = ? AND end_date < ?", end_time, true, date)
    rooms
  end
end
