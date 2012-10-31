class ReservationsController < ApplicationController
before_filter :authenticate_bar!, only: [:bar_accepts, :bar_rejects, :index]
before_filter :authenticate_user!, only: [:user_accepts, :user_rejects]

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

  def index
    redirect_to root_path(tab: "tab4")
  end

  def show
    @reservation = Reservation.find(params[:id])
    if bar_signed_in?
      @message = current_bar.messages.build
    elsif user_signed_in?
      @message = current_user.messages.build
    end      
  end

  def bar_accepts
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(bar_response: 1)
    redirect_to root_path(tab: "tab4")
  end

  def bar_rejects
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(bar_response: 2)
    redirect_to root_path(tab: "tab4")
  end

  def user_accepts
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(user_response: 1)
    redirect_to :back
  end

  def user_rejects
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(user_response: 2)
    redirect_to :back
  end
end