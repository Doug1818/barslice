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
      restriction.start_date = Date.strptime(params[:room][:restrictions_attributes].values[idx][:start_date],"%m/%d/%Y").to_time
      restriction.end_date = Date.strptime(params[:room][:restrictions_attributes].values[idx][:end_date],"%m/%d/%Y").to_time
    end if params[:room][:restrictions_attributes]
    if @room.save
      flash[:success] = "Room created"
      redirect_to root_path
    else
      flash[:error] = "Room not created"
      redirect_to new_room_path
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

  def edit
    @room = current_bar.rooms.find(params[:id])
  end

  def update
    @room = current_bar.rooms.find(params[:id])
    if @room.update_attributes(params[:room])
      flash[:success] = "Room updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end
end
