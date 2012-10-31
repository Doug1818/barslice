class MessagesController < ApplicationController

  def create
    @reservation = Reservation.find(params[:message][:reservation_id])
    @bar = Bar.find(Room.find(@reservation.room_id).bar_id)
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
      redirect_to reservation_path(@reservation)
      else
      render 'reservations/show'
    end
  end
end