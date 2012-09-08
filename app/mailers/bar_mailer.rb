class BarMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.bar_mailer.identity_confirmation.subject
  #
  def identity_confirmation(bar)
    @bar = bar

    mail from:"contact@barslice.com" , to: bar.email, subject: "Identity Confirmation"
  end
end
