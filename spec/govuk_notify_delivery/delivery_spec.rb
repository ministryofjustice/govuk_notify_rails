require 'spec_helper'
require 'govuk_notify_rails/delivery'

describe GovukNotifyRails::Delivery do
  describe '#deliver!' do
    let(:api_key) { 'api-key' }
    let(:notify_client) { double('NotifyClient') }
    let(:to) { ['email@example.com'] }

    let(:reference) { 'my_reference' }
    let(:reply_to) { 'email_reply_to_uuid' }
    let(:unsubscribe_url) { 'https://example.com/unsubscribe?token=123456' }

    let(:personalisation) { { name: 'John' } }

    let(:message) do
      instance_double(
        Mail::Message,
        to: to,
        govuk_notify_template: 'template-123',
        govuk_notify_reference: reference,
        govuk_notify_email_reply_to: reply_to,
        govuk_notify_one_click_unsubscribe_url: unsubscribe_url,
        govuk_notify_personalisation: personalisation
      )
    end

    subject { described_class.new(api_key: api_key) }

    before(:each) do
      allow(notify_client).to receive(:new).with(api_key).and_return(notify_client)
      allow(subject).to receive(:notify_client).and_return(notify_client)
      allow(message).to receive(:govuk_notify_responses=)
      allow(message).to receive(:govuk_notify_response=)
    end

    it 'should deliver the message payload' do
      expect(notify_client).to receive(:send_email).with(
        {
          email_address: 'email@example.com',
          template_id: 'template-123',
          reference: reference,
          email_reply_to_id: reply_to,
          one_click_unsubscribe_url: unsubscribe_url,
          personalisation: personalisation
        }
      )

      subject.deliver!(message)
    end

    context 'client response' do
      before do
        allow(notify_client).to receive(:send_email).and_return('response')
      end

      it 'returns the client response' do
        expect(subject.deliver!(message)).to eq(['response'])
      end

      it 'assigns the client responses for later inspection' do
        subject.deliver!(message)
        expect(message).to have_received(:govuk_notify_responses=).with(['response'])
      end

      it 'assigns the client response for later inspection' do
        subject.deliver!(message)
        expect(message).to have_received(:govuk_notify_response=).with('response')
      end
    end

    context 'multiple to addresses' do
      let(:to) { ['email1@example.com', 'email2@example.com'] }

      it 'supports messages without personalisation' do
        expect(notify_client).to receive(:send_email).with(
          a_hash_including(email_address: 'email1@example.com')
        )

        expect(notify_client).to receive(:send_email).with(
          a_hash_including(email_address: 'email2@example.com')
        )

        subject.deliver!(message)
      end

      context 'client response' do
        before do
          allow(notify_client).to receive(:send_email).and_return('response1', 'response2')
          subject.deliver!(message)
        end

        it 'assigns the client responses for later inspection' do
          expect(message).to have_received(:govuk_notify_responses=).with(['response1', 'response2'])
        end

        it 'assigns the first client response for later inspection' do
          expect(message).to have_received(:govuk_notify_response=).with('response1')
        end
      end
    end

    context 'no personalisation set' do
      let(:personalisation) { nil }

      it 'supports messages without personalisation' do
        expect(notify_client).to receive(:send_email).with(
          {
            email_address: 'email@example.com',
            template_id: 'template-123',
            reference: reference,
            email_reply_to_id: reply_to,
            one_click_unsubscribe_url: unsubscribe_url
          }
        )
        subject.deliver!(message)
      end
    end

    context 'no reference set' do
      let(:reference) { nil }

      it 'supports messages without a reference' do
        expect(notify_client).to receive(:send_email).with(
          {
            email_address: 'email@example.com',
            template_id: 'template-123',
            personalisation: personalisation,
            email_reply_to_id: reply_to,
            one_click_unsubscribe_url: unsubscribe_url
          }
        )
        subject.deliver!(message)
      end
    end

    context 'no reply to address set' do
      let(:reply_to) { nil }

      it 'supports messages without reply to address' do
        expect(notify_client).to receive(:send_email).with(
          {
            email_address: 'email@example.com',
            template_id: 'template-123',
            personalisation: personalisation,
            reference: reference,
            one_click_unsubscribe_url: unsubscribe_url
          }
        )
        subject.deliver!(message)
      end
    end

    context 'no unsubscribe url set' do
      let(:unsubscribe_url) { nil }

      it 'supports messages without unsubscribe url' do
        expect(notify_client).to receive(:send_email).with(
          {
            email_address: 'email@example.com',
            template_id: 'template-123',
            reference: reference,
            email_reply_to_id: reply_to,
            personalisation: personalisation
          }
        )
        subject.deliver!(message)
      end
    end
  end
end
