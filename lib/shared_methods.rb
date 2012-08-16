module SharedMethods
  
  def fspecials
    @fspecials ||= find_specials
  end

  def find_specials
    specials = Special.order(name)
    #rooms = rooms.joins(:specials).where("open_bar = ? AND specials.#{Date::DAYNAMES[date.wday].downcase} = ?", true, true) if has_open_bar.present?

    good_time = rooms.joins(:specials).where("(from <= ? AND until >= ?) AND specials.#{Date::DAYNAMES[date.wday].downcase} = ? 
      AND specials.start_date IS NULL AND specials.end_date IS NULL", start_time, end_time, true) if date.present?
    good_date = rooms.joins(:specials).where("specials.start_date <= ? AND specials.end_date >= ? 
      AND specials.#{Date::DAYNAMES[date.wday].downcase} = ? AND from IS NULL AND until IS NULL", date, date, true) if date.present?
    good_date_and_time = rooms.joins(:specials).where("(from <= ? AND until >= ?) AND specials.start_date <= ? AND specials.end_date >= ? 
      AND specials.#{Date::DAYNAMES[date.wday].downcase} = ?", start_time, end_time, date, date, true) if date.present?
    good_day = rooms.joins(:specials).where("specials.#{Date::DAYNAMES[date.wday].downcase} = ? 
      AND specials.start_date IS NULL AND specials.end_date IS NULL AND from IS NULL AND until IS NULL", true) if date.present?
    
    specials = good_time + good_date + good_date_and_time + good_day if !good_time.nil? && !good_date.nil? && !good_date_and_time.nil? && !good_day.nil?
    #bad_rooms.each do |bad_room|
    #  rooms.delete_if { |room| room == bad_room }
    #end if !bad_rooms.nil?

    specials
  end
end