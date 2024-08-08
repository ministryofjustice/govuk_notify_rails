class NotifyMailer < GovukNotifyRails::Mailer
  def test_email(user)
    set_template('9661d08a-486d-4c67-865e-ad976f17871d')
    set_reference('my_reference')
    set_email_reply_to('527c131f-ef4b-4b5b-8f9b-3202581af277')
    set_one_click_unsubscribe_url('https://example.com/unsubscribe?token=123456')

    set_personalisation(
      full_name: user.name
    )

    mail(to: user.email)
  end
end
