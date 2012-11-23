class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def resrequest_confirmation(user)
    @user = user
    @reservation = @user.reservations.last
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"contact@barslice.com", to: user.email, subject: "#{@bar.name} has received your reservation request"
  end

  def resaccepted(reservation)
    @reservation = reservation
    @user = User.find(@reservation.user_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"contact@barslice.com", to: @user.email, subject: "#{@bar.name} accepted your reservation request"
  end

  def resrejected(reservation)
    @reservation = reservation
    @user = User.find(@reservation.user_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"contact@barslice.com", to: @user.email, subject: "#{@bar.name} is unable to accept your reservation request"
  end

  def message_received(message)
    @message = message
    @reservation = Reservation.find(@message.reservation_id)
    @user = User.find(@reservation.user_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"contact@barslice.com", to: @user.email, subject: "#{@bar.name} sent you a message"
  end
end
