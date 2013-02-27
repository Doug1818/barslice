class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def resrequest_confirmation(user)
    @user = user
    @reservation = @user.reservations.last
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"BarSlice <contact@barslice.com>", to: user.email, subject: @bar.claimed == true ? "#{@bar.name} has received your reservation request" : "A reservation request is being sent to #{@bar.name}"
  end

  def resaccepted(reservation)
    @reservation = reservation
    @user = User.find(@reservation.user_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"BarSlice <contact@barslice.com>", to: @user.email, subject: "#{@bar.name} accepted your reservation request"
  end

  def resrejected(reservation)
    @reservation = reservation
    @user = User.find(@reservation.user_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"BarSlice <contact@barslice.com>", to: @user.email, subject: "#{@bar.name} is unable to accept your reservation request"
  end

  def message_received(message)
    @message = message
    @reservation = Reservation.find(@message.reservation_id)
    @user = User.find(@reservation.user_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"BarSlice <contact@barslice.com>", to: @user.email, subject: "#{@bar.name} sent you a message"
  end

  def charge_notice(charge)
    @charge = charge
    @reservation = Reservation.find(@charge.reservation_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    @user = User.find(@reservation.user_id)
    mail from:"BarSlice <payments@barslice.com>", to: @user.email, subject: "#{@bar.name} has charged your card"
  end

  def refund_notice(charge)
    @charge = charge
    @reservation = Reservation.find(@charge.reservation_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    @user = User.find(@reservation.user_id)
    mail from:"BarSlice <payments@barslice.com>", to: @user.email, subject: "#{@bar.name} has refunded you"
  end
end
