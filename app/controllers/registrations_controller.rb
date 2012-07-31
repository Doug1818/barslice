class RegistrationsController < Devise::RegistrationsController
  
  def new
    @bar = Bar.new
    @bar.hrsranges.new
  end

  def create
    @bar = Bar.new(params[:room])
    binding.pry
    @bar.hrsranges.each_with_index do |hrsrange, idx|
      hrsrange.open = params[:bar][:hrsranges_attributes].values[idx][:open].time_int
      hrsrange.close = params[:bar][:hrsranges_attributes].values[idx][:close].time_int
    end
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

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
end