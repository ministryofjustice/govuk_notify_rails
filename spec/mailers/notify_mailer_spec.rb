require 'spec_helper'
require 'govuk_notify_rails/mailer'

RSpec.describe NotifyMailer, type: :mailer do
  describe 'new_message_test_email' do
    let(:template) { '9661d08a-486d-4c67-865e-ad976f17871d' }
    let(:reference) { 'my_reference' }
    let(:reply_to) { '527c131f-ef4b-4b5b-8f9b-3202581af277' }
    let(:unsubscribe_url) { 'https://example.com/unsubscribe?token=123456' }

    let(:user) { double('User', name: 'Test Name', email: 'test@example.com') }
    let(:mail) { described_class.test_email(user) }

    it 'is a govuk_notify delivery' do
      expect(mail.delivery_method).to be_a(GovukNotifyRails::Delivery)
    end

    it 'sets the recipient' do
      expect(mail.to).to eq(['test@example.com'])
    end

    it 'sets the subject' do
      expect(mail.body).to match("This is a GOV.UK Notify email with template #{template}")
    end

    it 'sets the template' do
      expect(mail.govuk_notify_template).to eq(template)
    end

    it 'sets the reference' do
      expect(mail.govuk_notify_reference).to eq(reference)
    end

    it 'sets the reply_to' do
      expect(mail.govuk_notify_email_reply_to).to eq(reply_to)
    end

    it 'sets the unsubscribe url' do
      expect(mail.govuk_notify_one_click_unsubscribe_url).to eq(unsubscribe_url)
    end

    it 'sets the personalisation' do
      expect(mail.govuk_notify_personalisation.keys).to eq([:full_name])
    end
  end
end
