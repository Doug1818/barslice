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
    @room.restrictions.each_with_index do |restriction, idx|
      restriction.start_date = Date.strptime(params[:room][:restrictions_attributes].values[idx][:start_date],"%m/%d/%Y").to_date if !params[:room][:restrictions_attributes].values[idx][:start_date].blank?
      restriction.end_date = Date.strptime(params[:room][:restrictions_attributes].values[idx][:end_date],"%m/%d/%Y").to_date if !params[:room][:restrictions_attributes].values[idx][:end_date].blank?
      restriction.before = nil if params[:room][:restrictions_attributes].values[idx]["before(4i)"].blank?
      restriction.after = nil if params[:room][:restrictions_attributes].values[idx]["after(4i)"].blank?
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
end
