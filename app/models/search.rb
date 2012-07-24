class Search < ActiveRecord::Base
  attr_accessible :bar_name, :date, :hdct, :location, :privacy, :start_time, :end_time

  def rooms
  	@rooms ||= find_rooms
  end

private
  def find_rooms
  	rooms = Room.order(bar_name)
  	#rooms = rooms.where("Bar.find(Room.find_by_name(name).bar_id).name = ?", bar_name)
  	#rooms = rooms.hdctranges.where("min <= ?", hdct) if hdct.present?
  	#rooms = rooms.hdctranges.where("max >= ?", hdct) if hdct.present?
  	rooms = rooms.where("privacy = ?", privacy) if privacy.present?
  	rooms
  end
end
