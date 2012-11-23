class ReservationsController < ApplicationController
before_filter :authenticate_bar!, only: [:bar_accepts, :bar_rejects, :bar_show, :bar_index]
before_filter :authenticate_user!, only: [:user_accepts, :user_rejects, :user_show, :user_index]

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

  def bar_index
    redirect_to root_path(tab: "tab1")
  end

  def user_index
    redirect_to root_path(tab: "tab1")
  end

  def bar_show
    @reservation = Reservation.find(params[:id])
    @message = current_bar.messages.build
  end

  def user_show
    @reservation = Reservation.find(params[:id])
    @message = current_user.messages.build
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
  end

  def bar_accepts
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(bar_response: 1)
    redirect_to root_path(tab: "tab1")
    UserMailer.resaccepted(@reservation).deliver
  end

  def bar_rejects
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(bar_response: 2)
    redirect_to root_path(tab: "tab1")
    UserMailer.resrejected(@reservation).deliver
  end

  def user_accepts
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(user_response: 1)
    redirect_to root_path(tab: "tab1")
    BarMailer.resaccepted(@reservation).deliver
  end

  def user_rejects
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(user_response: 2)
    redirect_to root_path(tab: "tab1")
    BarMailer.resrejected(@reservation).deliver
  end
end