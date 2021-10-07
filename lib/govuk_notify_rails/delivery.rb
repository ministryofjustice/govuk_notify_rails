module GovukNotifyRails
  class Delivery
    attr_accessor :settings

    def initialize(settings)
      self.settings = settings
    end

    def deliver!(message)
      payload = payload_for(message)

      responses = message.to.map do |to|
        notify_client.send_email(
          payload.merge(email_address: to)
        )
      end

      message.govuk_notify_responses = responses

      # For backwards compatibility
      message.govuk_notify_response = responses.first

      responses
    end

    private

    def api_key
      settings[:api_key]
    end

    def payload_for(message)
      {
        template_id: message.govuk_notify_template,
        reference: message.govuk_notify_reference,
        personalisation: message.govuk_notify_personalisation,
        email_reply_to_id: message.govuk_notify_email_reply_to
      }.compact
    end

    def notify_client
      @notify_client ||= Notifications::Client.new(api_key)
    end
  end
end
