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

  def identity_confirmation_alert(bar)
    @bar = bar
    mail from:"contact@barslice.com" , to: "doug@barslice.com", subject: "[Identity Confirmation]#{bar.name}"
  end

  def claimed_bar_alert(bar)
    @bar = bar
    mail from:"contact@barslice.com" , to: "doug@barslice.com", subject: "[Claimed Bar]#{bar.name}"
  end
end
