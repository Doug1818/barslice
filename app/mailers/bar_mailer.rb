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
    mail from:"contact@barslice.com" , to: bar.email, subject: "Identity Confirmation"
  end
end
