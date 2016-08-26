ActionMailer::Base.add_delivery_method :govuk_notify, GovukNotifyRails::Delivery,
                                       service_id: 'test-service-id',
                                       secret_key: 'test-secret-key'
