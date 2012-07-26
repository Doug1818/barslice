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
  	rooms = rooms.joins(:hdctranges).where("min <= ?", hdct) if hdct.present?
  	rooms = rooms.joins(:hdctranges).where("max >= ?", hdct) if hdct.present?
  	rooms = rooms.where("privacy = ?", privacy) if privacy.present?
  	rooms = rooms.joins(:bar).joins(:bar => :hrsranges).where("open <= ? AND #{Date::DAYNAMES[date.wday].downcase} = ?", start_time, true) if start_time.present?
  	rooms = rooms.joins(:bar).joins(:bar => :hrsranges).where("close >= ? AND #{Date::DAYNAMES[date.wday].downcase} = ?", end_time, true) if end_time.present?
  	rooms
  end
end
