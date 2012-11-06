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
      if !params[:room][:restrictions_attributes].values[idx][:start_date].blank?
        restriction.start_date = Date.strptime(params[:room][:restrictions_attributes].values[idx][:start_date],"%m/%d/%Y").to_date
      end
      if !params[:room][:restrictions_attributes].values[idx][:end_date].blank?
        restriction.end_date = Date.strptime(params[:room][:restrictions_attributes].values[idx][:end_date],"%m/%d/%Y").to_date
      end
      if !params[:room][:restrictions_attributes].values[idx][:before].blank?
        restriction.before = TIMES[params[:room][:restrictions_attributes].values[idx][:before]]
      end
      if !params[:room][:restrictions_attributes].values[idx][:after].blank?
        restriction.after = TIMES[params[:room][:restrictions_attributes].values[idx][:after]]
      end
    end if params[:room][:restrictions_attributes]
    if @room.save
      flash[:success] = "Room added"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @room = current_bar.rooms.find(params[:id])
  end

  def update
    @room = current_bar.rooms.find(params[:id])
    params[:room][:restrictions_attributes].values.each do |restriction|
      restriction[:start_date] = Date.strptime(restriction[:start_date],"%m/%d/%Y").to_date if !restriction[:start_date].blank?
      restriction[:end_date] = Date.strptime(restriction[:end_date],"%m/%d/%Y").to_date if !restriction[:end_date].blank?
      restriction[:before] = TIMES[restriction[:before]] if !restriction[:before].blank?
      restriction[:after] = TIMES[restriction[:after]] if !restriction[:after].blank?
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
    redirect_to root_path(tab: "tab2")
  end
end