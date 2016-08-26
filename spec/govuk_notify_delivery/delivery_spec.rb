require 'spec_helper'
require 'govuk_notify_rails/delivery'

describe GovukNotifyRails::Delivery do
  describe '#deliver!' do
    let(:service_id) { 'service-123' }
    let(:secret_key) { 'secret' }
    let(:notify_client) { double('NotifyClient') }

    let(:personalisation) { { name: 'John' } }

    let(:message) do
      instance_double(Mail::Message,
                      to: ['email@example.com'],
                      govuk_notify_template: 'template-123',
                      govuk_notify_personalisation: personalisation)
    end

    subject { described_class.new(service_id: service_id, secret_key: secret_key) }

    before(:each) do
      allow(notify_client).to receive(:new).with(service_id, secret_key).and_return(notify_client)
      allow(subject).to receive(:notify_client).and_return(notify_client)
    end

    it 'should deliver the message payload' do
      expect(notify_client).to receive(:send_email).with('{"to":"email@example.com","template":"template-123","personalisation":{"name":"John"}}')
      subject.deliver!(message)
    end

    context 'no personalisation set' do
      let(:personalisation) { nil }

      it 'supports message without personalisation' do
        expect(notify_client).to receive(:send_email).with('{"to":"email@example.com","template":"template-123"}')
        subject.deliver!(message)
      end
    end
  end
end
