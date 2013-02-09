class ReservationsController < ApplicationController
before_filter :authenticate_bar!, only: [:bar_accepts, :bar_rejects, :bar_show, :bar_index, 
  :charge_user, :bar_past_events, :bar_never_were]
before_filter :authenticate_user!, only: [:new, :create, :user_accepts, :user_rejects, :user_show, 
  :user_index, :user_past_events, :user_never_were]

  def bar_past_events
  end

  def bar_never_were
  end
  
  def user_past_events
    @search = Search.new
  end

  def user_never_were
    @search = Search.new
  end

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
      if @bar.claimed == true
        flash[:success] = "Your reservation request has been sent to #{@bar.name}. You will be notified of their availability by email as soon as possible."
      else
        flash[:success] = "A reservation request is being sent to #{@bar.name}. You will be notified of their availability by email as soon as possible."
      end
      redirect_to root_path
      BarMailer.resrequest(@room, @bar, @user).deliver
      UserMailer.resrequest_confirmation(@user).deliver
    else
      render 'new'
    end
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes!(params[:reservation])
    respond_to do |format|
      format.html { redirect_to bar_show_reservation_path(@reservation) }
      format.js
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
    @room = Room.find(@reservation.room_id)
    @user = User.find(@reservation.user_id)
    @charge = Charge.new
  end

  def user_show
    @reservation = Reservation.find(params[:id])
    @message = current_user.messages.build
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
  end

  def bar_accepts
    @reservation = Reservation.find(params[:id])
    @user = User.find(@reservation.user_id)
    @reservation.update_attributes(bar_response: 1, bar_accepts_date: Time.now)
    flash[:success] = "A notification email has been sent to #{@user.name} letting them know you have accepted their reservation request for #{@reservation.date.strftime("%A, %B %e")}."
    redirect_back_or_root_path
    UserMailer.resaccepted(@reservation).deliver
  end

  def bar_rejects
    @reservation = Reservation.find(params[:id])
    @user = User.find(@reservation.user_id)
    @reservation.update_attributes(bar_response: 2, bar_rejects_date: Time.now)
    flash[:success] = "A notification email has been sent to #{@user.name} letting them know you are unable to accomodate their reservation on #{@reservation.date.strftime("%A, %B %e")}."
    redirect_back_or_root_path
    UserMailer.resrejected(@reservation).deliver
  end

  def user_accepts
    @reservation = Reservation.find(params[:id])
    @user = User.find(@reservation.user_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    if @reservation.update_attributes(
        respolicy_accepted: params[:reservation][:respolicy_accepted], 
        user_response: 1, 
        user_accepts_date: Time.now)
      # Update or Create stripe customer
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      if @user.stripe_customer_id? && params[:reservation][:stripe_card_token] != ""
        customer = Stripe::Customer.retrieve(@user.stripe_customer_id)
        customer.card = params[:reservation][:stripe_card_token]
        customer.save
        @user.stripe_card_type = customer.active_card.type
        @user.stripe_card_last4 = customer.active_card.last4
        @user.save
      elsif @user.stripe_customer_id == nil
        customer = Stripe::Customer.create(
          :card => params[:reservation][:stripe_card_token],
          :email => @user.email,
          :description => @user.name)
        @user.stripe_customer_id = customer.id
        @user.stripe_card_type = customer.active_card.type
        @user.stripe_card_last4 = customer.active_card.last4
        @user.save
      end
      # Delete same night reservations still pending at other bars
      @user.reservations.each do |reservation|
        if reservation.date == @reservation.date && reservation != @reservation && reservation.user_response != 2
          reservation.update_attributes(user_response: 2, user_rejects_date: Time.now)
          BarMailer.resrejected(reservation).deliver
        end
      end
      flash[:success] = "A notification email has been sent to #{@bar.name} letting them know you have confirmed your reservation for #{@reservation.date.strftime("%A, %B %e")}."
      redirect_back_or_root_path
      BarMailer.resaccepted(@reservation).deliver
    else
      render 'reservations/user_show'
    end
  end

  def user_rejects
    @reservation = Reservation.find(params[:id])
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    @reservation.update_attributes(user_response: 2, user_rejects_date: Time.now)
    flash[:success] = "A notification email has been sent to #{@bar.name} letting them know you have cancelled your reservation for #{@reservation.date.strftime("%A, %B %e")}."
    redirect_back_or_root_path
    BarMailer.resrejected(@reservation).deliver
  end

 private
  def redirect_back_or_root_path
    if request.referrer.include?("bars/sign_in") || request.referrer.include?("users/sign_in")
      redirect_to root_path(tab: "tab1")
    else
      redirect_to :back
    end
  rescue ActionController::RedirectBackError
    redirect_to root_path(tab: "tab1")
  end
end