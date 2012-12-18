class MessagesController < ApplicationController
before_filter :authenticate_bar!, only: [:bar_view_attachment]
before_filter :authenticate_user!, only: [:user_view_attachment]

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
        UserMailer.message_received(@message).deliver
      elsif user_signed_in?
        redirect_to user_show_reservation_path(@reservation)
        BarMailer.message_received(@message).deliver
      end
    else
      if bar_signed_in?
        flash[:error] = "Message can't be blank."
        render 'reservations/bar_show'
        #redirect_to root_path + "reservations/" + "#{@reservation.id}" + "/bar_show#msgform"
      elsif user_signed_in?
        flash[:error] = "Message can't be blank."
        render 'reservations/user_show'
        #redirect_to root_path + "reservations/" + "#{@reservation.id}" + "/user_show#msgform"
      end
    end
  end

  def bar_view_attachment
    @message = Message.find(params[:id])
    redirect_to @message.attachment.expiring_url(10)
  end

  def user_view_attachment
    @message = Message.find(params[:id])
    redirect_to @message.attachment.expiring_url(10)
  end
end