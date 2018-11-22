require 'spec_helper'
require 'govuk_notify_rails/delivery'

describe GovukNotifyRails::Delivery do
  describe '#deliver!' do
    let(:api_key) { 'api-key' }
    let(:notify_client) { double('NotifyClient') }

    let(:personalisation) { { name: 'John' } }
    let(:reference) { 'my_reference' }

    let(:message) do
      instance_double(
        Mail::Message,
        to: ['email@example.com'],
        govuk_notify_template: 'template-123',
        govuk_notify_reference: reference,
        govuk_notify_personalisation: personalisation
      )
    end

    subject { described_class.new(api_key: api_key) }

    before(:each) do
      allow(notify_client).to receive(:new).with(api_key).and_return(notify_client)
      allow(subject).to receive(:notify_client).and_return(notify_client)
      allow(message).to receive(:govuk_notify_response=)
    end

    it 'should deliver the message payload' do
      expect(notify_client).to receive(:send_email).with(
        {email_address: 'email@example.com', template_id: 'template-123', reference: reference, personalisation: personalisation}
      )
      subject.deliver!(message)
    end

    context 'client response' do
      before do
        allow(notify_client).to receive(:send_email).and_return('response')
      end

      it 'returns the client response' do
        expect(subject.deliver!(message)).to eq('response')
      end

      it 'assigns the client response for later inspection' do
        subject.deliver!(message)
        expect(message).to have_received(:govuk_notify_response=).with('response')
      end
    end

    context 'no personalisation set' do
      let(:personalisation) { nil }

      it 'supports messages without personalisation' do
        expect(notify_client).to receive(:send_email).with(
          {email_address: 'email@example.com', template_id: 'template-123', reference: reference}
        )
        subject.deliver!(message)
      end
    end

    context 'no reference set' do
      let(:reference) { nil }

      it 'supports messages without a reference' do
        expect(notify_client).to receive(:send_email).with(
          {email_address: 'email@example.com', template_id: 'template-123', personalisation: personalisation}
        )
        subject.deliver!(message)
      end
    end
  end
end
