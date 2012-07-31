class RoomsController < ApplicationController
before_filter :authenticate_bar!, only: [:new, :create, :destroy, :edit, :update]

  def new
    @room = Room.new
    @room.hdctranges.new
    @room.fees.new
    @room.spendmins.new
    @room.restrictions.new
    @room.roompics.new
  end

  def create
    @room = current_bar.rooms.build(params[:room])
    #binding.pry
    @room.restrictions.each_with_index do |restriction, idx|
      restriction.start_date = Date.strptime(params[:room][:restrictions_attributes].values[idx][:start_date],"%m/%d/%Y").to_date if !params[:room][:restrictions_attributes].values[idx][:start_date].blank?
      restriction.end_date = Date.strptime(params[:room][:restrictions_attributes].values[idx][:end_date],"%m/%d/%Y").to_date if !params[:room][:restrictions_attributes].values[idx][:end_date].blank?

      time_int(restriction.after, params[:room][:restrictions_attributes].values[idx][:after])

#      restriction.before = params[:room][:restrictions_attributes].values[idx][:before].time_int if !params[:room][:restrictions_attributes].values[idx][:before].blank?
#      restriction.after = params[:room][:restrictions_attributes].values[idx][:after].time_int if !params[:room][:restrictions_attributes].values[idx][:after].blank?
    end if params[:room][:restrictions_attributes]
    if @room.save
      flash[:success] = "Room created"
      redirect_to root_path
    else
      flash[:error] = "Room not created"
      redirect_to new_room_path
    end
  end

  def edit
    @room = current_bar.rooms.find(params[:id])
    @room.restrictions.each do |restriction|
      restriction.start_date = restriction.start_date.strftime("%m/%d/%Y") if restriction.start_date
      restriction.end_date = restriction.end_date.strftime("%m/%d/%Y") if restriction.end_date
    end
  end

  def update
    @room = current_bar.rooms.find(params[:id])
    params[:room][:restrictions_attributes].values.each do |restriction|
      restriction[:start_date] = Date.strptime(restriction[:start_date],"%m/%d/%Y").to_date if !restriction[:start_date].blank?
      restriction[:end_date] = Date.strptime(restriction[:end_date],"%m/%d/%Y").to_date if !restriction[:end_date].blank?
      if restriction["before(4i)"].blank?
        restriction["before(1i)"] = ""
        restriction["before(2i)"] = ""
        restriction["before(3i)"] = ""
        restriction["before(5i)"] = ""
      end
      if restriction["after(4i)"].blank?
        restriction["after(1i)"] = ""
        restriction["after(2i)"] = ""
        restriction["after(3i)"] = ""
        restriction["after(5i)"] = ""
      end
    end if params[:room][:restrictions_attributes]
    if @room.update_attributes(params[:room])
      flash[:success] = "Room updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @room = current_bar.rooms.find(params[:id])
    @room.destroy
    flash[:notice] = "Room deleted"
    redirect_to root_path
  end

  def show
    @room = Room.find(params[:id])
  end

  def index
  end

  def testmethod
    if self == "11:00 PM"
      rtn = 1100
    else
      rtn = nil
    end
  end

  def time_int(result, value)
    result = case value
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

  def temp
    case before
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

  def temp
    case params[:room][:restrictions_attributes].values[idx][:after]
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
