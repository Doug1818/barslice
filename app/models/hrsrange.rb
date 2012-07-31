class Hrsrange < ActiveRecord::Base
  attr_accessible :close, :friday, :monday, :saturday, :open, :sunday, :thursday, :tuesday, :wednesday
  belongs_to :bar

  before_save do |hrsrange|
  	if hrsrange.open? && hrsrange.close? && !hrsrange.sunday && !hrsrange.monday && !hrsrange.tuesday && !hrsrange.wednesday && !hrsrange.thursday && !hrsrange.friday && !hrsrange.saturday
  		hrsrange.sunday = true && hrsrange.monday = true && hrsrange.tuesday = true && hrsrange.wednesday = true && hrsrange.thursday = true && hrsrange.friday = true && hrsrange.saturday = true
	end
  end

  before_save do |hrsrange|
	hrsrange.open = open.time_int
	hrsrange.close = close.time_int
  end

  TIMES = ["6:30 AM", "7:00 AM", "7:30 AM", "8:00 AM", "8:30 AM", "9:00 AM", "9:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "1:00 PM", "1:30 PM", "2:00 PM", "2:30 PM", "3:00 PM", "3:30 PM", "4:00 PM", "4:30 PM", "5:00 PM", "5:30 PM", "6:00 PM", "6:30 PM", "7:00 PM", "7:30 PM", "8:00 PM", "8:30 PM", "9:00 PM", "9:30 PM", "10:00 PM", "10:30 PM", "11:00 PM", "11:30 PM", "12:00 AM", "12:30 AM", "1:00 AM", "1:30 AM", "2:00 AM", "2:30 AM", "3:00 AM", "3:30 AM", "4:00 AM", "4:30 AM", "5:00 AM", "5:30 AM", "6:00 AM"]

  def time_int
  	case open
  		when  "6:30 AM" then  630
  		when  "7:00 AM" then  700
  		when  "7:30 AM" then  730
  		when  "8:00 AM" then  800  
  		when  "8:30 AM" then  830
  		when  "9:00 AM" then  900
  		when  "9:30 AM" then  930
  		when "10:00 AM" then 1000
  		when "10:30 AM" then 1030
  		when "11:00 AM" then 1100
		when "11:30 AM" then 1130
		when "12:00 PM" then 1200
		when "12:30 PM" then 1230
		when  "1:00 PM" then 1300
		when  "1:30 PM" then 1330
		when  "2:00 PM" then 1400
		when  "2:30 PM" then 1430
		when  "3:00 PM" then 1500
		when  "3:30 PM" then 1530
		when  "4:00 PM" then 1600
		when  "4:30 PM" then 1630
		when  "5:00 PM" then 1700
		when  "5:30 PM" then 1730
		when  "6:00 PM" then 1800
		when  "6:30 PM" then 1830
		when  "7:00 PM" then 1900
		when  "7:30 PM" then 1930
		when  "8:00 PM" then 2000
		when  "8:30 PM" then 2030
		when  "9:00 PM" then 2100
		when  "9:30 PM" then 2130
		when "10:00 PM" then 2200
		when "10:30 PM" then 2230
		when "11:00 PM" then 2300
		when "11:30 PM" then 2330
		when "12:00 AM" then 2400
		when "12:30 AM" then 2430
		when  "1:00 AM" then 2500
		when  "1:30 AM" then 2530
		when  "2:00 AM" then 2600
		when  "2:30 AM" then 2630
		when  "3:00 AM" then 2700
		when  "3:30 AM" then 2730
		when  "4:00 AM" then 2800
		when  "4:30 AM" then 2830
		when  "5:00 AM" then 2900
		when  "5:30 AM" then 2930
		when  "6:00 AM" then 3000
		else "Unknown"
	end
  end

  def time_str
  	case open
  		when  630 then  "6:30 AM"
  		when  700 then  "7:00 AM"
  		when  730 then  "7:30 AM"
  		when  800 then  "8:00 AM"
  		when  830 then  "8:30 AM"
  		when  900 then  "9:00 AM"
  		when  930 then  "9:30 AM"
  		when 1000 then "10:00 AM"
  		when 1030 then "10:30 AM"
  		when 1100 then "11:00 AM"
		when 1130 then "11:30 AM"
		when 1200 then "12:00 PM"
		when 1230 then "12:30 PM"
		when 1300 then  "1:00 PM"
		when 1330 then  "1:30 PM"
		when 1400 then  "2:00 PM"
		when 1430 then  "2:30 PM"
		when 1500 then  "3:00 PM"
		when 1530 then  "3:30 PM"
		when 1600 then  "4:00 PM"
		when 1630 then  "4:30 PM"
		when 1700 then  "5:00 PM"
		when 1730 then  "5:30 PM"
		when 1800 then  "6:00 PM"
		when 1830 then  "6:30 PM"
		when 1900 then  "7:00 PM"
		when 1930 then  "7:30 PM"
		when 2000 then  "8:00 PM"
		when 2030 then  "8:30 PM"
		when 2100 then  "9:00 PM"
		when 2130 then  "9:30 PM"
		when 2200 then "10:00 PM"
		when 2230 then "10:30 PM"
		when 2300 then "11:00 PM"
		when 2330 then "11:30 PM"
		when 2400 then "12:00 AM"
		when 2430 then "12:30 AM"
		when 2500 then  "1:00 AM"
		when 2530 then  "1:30 AM"
		when 2600 then  "2:00 AM"
		when 2630 then  "2:30 AM"
		when 2700 then  "3:00 AM"
		when 2730 then  "3:30 AM"
		when 2800 then  "4:00 AM"
		when 2830 then  "4:30 AM"
		when 2900 then  "5:00 AM"
		when 2930 then  "5:30 AM"
		when 3000 then  "6:00 AM"
		else "Unknown"
	end
  end

  def time_int
  	case close
  		when  "6:30 AM" then  630
  		when  "7:00 AM" then  700
  		when  "7:30 AM" then  730
  		when  "8:00 AM" then  800  
  		when  "8:30 AM" then  830
  		when  "9:00 AM" then  900
  		when  "9:30 AM" then  930
  		when "10:00 AM" then 1000
  		when "10:30 AM" then 1030
  		when "11:00 AM" then 1100
		when "11:30 AM" then 1130
		when "12:00 PM" then 1200
		when "12:30 PM" then 1230
		when  "1:00 PM" then 1300
		when  "1:30 PM" then 1330
		when  "2:00 PM" then 1400
		when  "2:30 PM" then 1430
		when  "3:00 PM" then 1500
		when  "3:30 PM" then 1530
		when  "4:00 PM" then 1600
		when  "4:30 PM" then 1630
		when  "5:00 PM" then 1700
		when  "5:30 PM" then 1730
		when  "6:00 PM" then 1800
		when  "6:30 PM" then 1830
		when  "7:00 PM" then 1900
		when  "7:30 PM" then 1930
		when  "8:00 PM" then 2000
		when  "8:30 PM" then 2030
		when  "9:00 PM" then 2100
		when  "9:30 PM" then 2130
		when "10:00 PM" then 2200
		when "10:30 PM" then 2230
		when "11:00 PM" then 2300
		when "11:30 PM" then 2330
		when "12:00 AM" then 2400
		when "12:30 AM" then 2430
		when  "1:00 AM" then 2500
		when  "1:30 AM" then 2530
		when  "2:00 AM" then 2600
		when  "2:30 AM" then 2630
		when  "3:00 AM" then 2700
		when  "3:30 AM" then 2730
		when  "4:00 AM" then 2800
		when  "4:30 AM" then 2830
		when  "5:00 AM" then 2900
		when  "5:30 AM" then 2930
		when  "6:00 AM" then 3000
		else "Unknown"
	end
  end

  def time_str
  	case close
  		when  630 then  "6:30 AM"
  		when  700 then  "7:00 AM"
  		when  730 then  "7:30 AM"
  		when  800 then  "8:00 AM"
  		when  830 then  "8:30 AM"
  		when  900 then  "9:00 AM"
  		when  930 then  "9:30 AM"
  		when 1000 then "10:00 AM"
  		when 1030 then "10:30 AM"
  		when 1100 then "11:00 AM"
		when 1130 then "11:30 AM"
		when 1200 then "12:00 PM"
		when 1230 then "12:30 PM"
		when 1300 then  "1:00 PM"
		when 1330 then  "1:30 PM"
		when 1400 then  "2:00 PM"
		when 1430 then  "2:30 PM"
		when 1500 then  "3:00 PM"
		when 1530 then  "3:30 PM"
		when 1600 then  "4:00 PM"
		when 1630 then  "4:30 PM"
		when 1700 then  "5:00 PM"
		when 1730 then  "5:30 PM"
		when 1800 then  "6:00 PM"
		when 1830 then  "6:30 PM"
		when 1900 then  "7:00 PM"
		when 1930 then  "7:30 PM"
		when 2000 then  "8:00 PM"
		when 2030 then  "8:30 PM"
		when 2100 then  "9:00 PM"
		when 2130 then  "9:30 PM"
		when 2200 then "10:00 PM"
		when 2230 then "10:30 PM"
		when 2300 then "11:00 PM"
		when 2330 then "11:30 PM"
		when 2400 then "12:00 AM"
		when 2430 then "12:30 AM"
		when 2500 then  "1:00 AM"
		when 2530 then  "1:30 AM"
		when 2600 then  "2:00 AM"
		when 2630 then  "2:30 AM"
		when 2700 then  "3:00 AM"
		when 2730 then  "3:30 AM"
		when 2800 then  "4:00 AM"
		when 2830 then  "4:30 AM"
		when 2900 then  "5:00 AM"
		when 2930 then  "5:30 AM"
		when 3000 then  "6:00 AM"
		else "Unknown"
	end
  end
end
