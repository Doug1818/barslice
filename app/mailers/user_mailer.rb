class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def resrequest_confirmation(user)
    @user = user
    @reservation = @user.reservations.last
    @room = Room.find(@reservation.room_id)
    @bar = Bar.find(@room.bar_id)
    mail from:"contact@barslice.com", to: user.email, subject: "Reservation Request Confirmation"
  end
end
