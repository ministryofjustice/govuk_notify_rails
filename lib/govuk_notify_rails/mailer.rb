module GovukNotifyRails
  class Mailer < ActionMailer::Base
    default delivery_method: :govuk_notify

    attr_accessor :govuk_notify_template
    attr_accessor :govuk_notify_reference
    attr_accessor :govuk_notify_personalisation
    attr_accessor :govuk_notify_email_reply_to
    attr_accessor :govuk_notify_one_click_unsubscribe_url

    protected

    def mail(headers = {})
      raise ArgumentError, 'Missing template ID. Make sure to use `set_template` before calling `mail`' if govuk_notify_template.nil?

      headers[:body] ||= _default_body

      message = super(headers)
      message.govuk_notify_template = govuk_notify_template
      message.govuk_notify_reference = govuk_notify_reference
      message.govuk_notify_personalisation = govuk_notify_personalisation
      message.govuk_notify_email_reply_to = govuk_notify_email_reply_to
      message.govuk_notify_one_click_unsubscribe_url = govuk_notify_one_click_unsubscribe_url
    end

    def set_template(template)
      self.govuk_notify_template = template
    end

    def set_reference(reference)
      self.govuk_notify_reference = reference
    end

    def set_personalisation(personalisation)
      self.govuk_notify_personalisation = personalisation
    end

    def set_email_reply_to(address)
      self.govuk_notify_email_reply_to = address
    end

    def set_one_click_unsubscribe_url(url)
      self.govuk_notify_one_click_unsubscribe_url = url
    end

    def _default_body
      'This is a GOV.UK Notify email with template %s and personalisation: %s' % [govuk_notify_template, govuk_notify_personalisation]
    end
  end
end
