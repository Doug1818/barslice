class MessagesController < ApplicationController

  def create
    @reservation = Reservation.find(params[:message][:reservation_id])
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    @user = User.find(@reservation.user_id)
    if bar_signed_in?
      @message = @bar.messages.build(params[:message])
      @message.sent_by = 0
      @message.user_id = @user.id
    elsif user_signed_in?
      @message = @user.messages.build(params[:message])
      @message.sent_by = 1
      @message.bar_id = @bar.id
    end
    if @message.save
      flash[:success] = "Your message has been sent."
      if bar_signed_in?
        redirect_to bar_show_reservation_path(@reservation)
      elsif user_signed_in?
        redirect_to user_show_reservation_path(@reservation)
      end
    else
      if bar_signed_in?
        render 'reservations/bar_show'
      elsif user_signed_in?
        render 'reservations/user_show'
      end
    end
  end
end