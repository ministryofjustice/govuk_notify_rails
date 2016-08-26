class NotifyMailer < GovukNotifyRails::Mailer
  def test_email(user)
    set_template('9661d08a-486d-4c67-865e-ad976f17871d')
    set_personalisation(
      full_name: user.name
    )

    mail(to: user.email)
  end
end
