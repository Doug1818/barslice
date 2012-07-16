class RoomsController < ApplicationController
before_filter :authenticate_bar!

  def new
    @room = Room.new
    @room.restrictions.new
    @room.roompics.new
  end

  def create
    @room = current_bar.rooms.build(params[:room])
    if @room.save
      flash[:success] = "Room created!"
      redirect_to root_path
    else
      flash[:error] = "Room not created!"
      redirect_to new_room_path
    end
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end
end