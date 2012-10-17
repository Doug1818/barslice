class ReservationsController < ApplicationController

  def new
  	@reservation = Reservation.new
    @room = Room.find(params[:format])
    @bar = Bar.find(@room.bar_id)
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @bar = Bar.find(@room.bar_id)
    @user = current_user
    @reservation = @room.reservations.build(params[:reservation])
    @reservation.date = Date.strptime(params[:reservation][:date],"%m/%d/%Y").to_date if params[:reservation][:date] != ""
    @reservation.start_time = TIMES[params[:reservation][:start_time]]
    @reservation.end_time = TIMES[params[:reservation][:end_time]]
    @reservation.user_id = @user.id
    if @reservation.save
      flash[:success] = "Your reservation request has been sent to #{@bar.name}. You will be notified of their availability by email as soon as possible."
      redirect_to root_path
      BarMailer.resrequest(@room, @bar, @user).deliver
      UserMailer.resrequest_confirmation(@user).deliver
    else
      render 'new'
    end
  end
end