module Mail
  class Message
    attr_accessor :govuk_notify_template
    attr_accessor :govuk_notify_reference
    attr_accessor :govuk_notify_email_reply_to
    attr_accessor :govuk_notify_one_click_unsubscribe_url

    attr_accessor :govuk_notify_personalisation

    attr_accessor :govuk_notify_response
    attr_accessor :govuk_notify_responses
  end
end
