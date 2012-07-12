class RoomsController < ApplicationController
  
  def new
    @room = Room.new
  end

  def create
    @room = current_bar.rooms.build(params[:room])
    if @room.save
      flash[:success] = "Room created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
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