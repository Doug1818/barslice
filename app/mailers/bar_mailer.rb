class BarMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.bar_mailer.identity_confirmation.subject
  #
  def identity_confirmation(bar)
    @bar = bar
    @temp_pass = Rufus::Mnemo::from_integer(@bar.id*10000)[0..5]
    mail from:"contact@barslice.com", to: bar.email, subject: "Identity Confirmation"
  end

  def identity_confirmation_alert(bar)
    @bar = bar
    mail from:"contact@barslice.com", to: "doug@barslice.com", subject: "[Identity Confirmation]#{bar.name}"
  end

  def claimed_bar_alert(bar)
    @bar = bar
    mail from:"contact@barslice.com", to: "doug@barslice.com", subject: "[Claimed Bar]#{bar.name}"
  end

  def resrequest(room, bar, user)
    @room = room
    @bar = bar
    @user = user
    @reservation = @user.reservations.last
    mail from:"contact@barslice.com", to: bar.email, subject: "You have a new reservation request"
  end

  def resaccepted(reservation)
    @reservation = reservation
    @user = User.find(@reservation.user_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"contact@barslice.com", to: @bar.email, subject: "#{@user.name} confirmed a reservation"
  end

  def resrejected(reservation)
    @reservation = reservation
    @user = User.find(@reservation.user_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"contact@barslice.com", to: @bar.email, subject: "#{@user.name} cancelled a reservation"
  end

  def message_received(message)
    @message = message
    @reservation = Reservation.find(@message.reservation_id)
    @user = User.find(@reservation.user_id)
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"contact@barslice.com", to: @bar.email, subject: "#{@user.name} sent you a message"
  end
end
