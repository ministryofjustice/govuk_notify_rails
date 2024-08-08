# GovukNotifyRails

Custom ActionMailer delivery to send emails via the API client for GOV.UK Notify.

[![Gem Version](https://badge.fury.io/rb/govuk_notify_rails.svg)](https://badge.fury.io/rb/govuk_notify_rails)

## Installation

Prior to usage an account must be created through the [GOV.UK Notify](https://www.notifications.service.gov.uk) admin console. This will provide the API credentials needed in you application.

You can then install the gem or require it in your application.

```ruby
gem 'govuk_notify_rails'
```

Please note the latest version of this gem makes use of the [notifications-ruby-client](https://github.com/alphagov/notifications-ruby-client) gem version ~> 6.2

You can use a specific client version in your Gemfile if you want, granting there are no breaking changes in the interface.

In your app, you will need to add the delivery method, and set the `api_key`, for example with an initializer:

```ruby
ActionMailer::Base.add_delivery_method :govuk_notify, GovukNotifyRails::Delivery,
  api_key: ENV['GOVUK_NOTIFY_API_KEY']
```

## Usage

To send emails through GOV.UK Notify, create your mailers like usual but inheriting from `GovukNotifyRails::Mailer`. Then just use `mail()` as with any other ActionMailer passing the recipient email.

The template ID is mandatory, but the reference and personalisation are optional.

```ruby
class NotifyMailer < GovukNotifyRails::Mailer
  #
  # Define methods as usual, and set the template and personalisation accordingly
  #
  def my_test_email(user)
    set_template('uuid')

    # Optionally, you can set a reference, a reply_to and an unsubscribe url
    # 
    set_reference('my_reference_string')
    set_email_reply_to('uuid')
    set_one_click_unsubscribe_url('https://example.com/unsubscribe?token=123456')
    
    set_personalisation(
      full_name: user.full_name,
      address: user.address
    )
    
    mail(to: user.email)
  end
end
```

After a successful delivery, you can inspect the returned `Notifications::Client:ResponseNotification` for details of the delivery. For example:

```ruby
response = NotifyMailer.my_test_email(user).deliver_now
response.govuk_notify_response.id  # notification UUID
response.govuk_notify_response.template  # id, version and uri of the template
```

If the mail should be sent to multiple recipients, multiple API calls are made to GOV.UK Notify. You can expect each of the responses in a similar way:

```ruby
response = NotifyMailer.my_test_email(users).deliver_now
response.govuk_notify_responses.first.id  # notification UUID
response.govuk_notify_responses.second.template  # id, version and uri of the template
```

For more information, refer to the [Notify documentation](https://docs.notifications.service.gov.uk/ruby.html#ruby-client-documentation).

### Mailer previewing

You can also create mailer previews as usual. The preview will however be a sample string as the actual template is hosted in the GOV.UK Notify website.

For example:

```ruby
class NotifyMailerPreview < ActionMailer::Preview
  
  def my_test_email
    user = User.first
    NotifyMailer.my_test_email(user)
  end
  
end
```

With your local rails server running you can browse to ```http://localhost:3000/rails/mailers``` to view a list of current email templates

## Contributing

Bug reports and pull requests are welcome.

1. Fork the project
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit until you are happy with your contribution (`git commit -am 'Add some feature'`)
4. Push the branch (`git push origin my-new-feature`)
5. Make sure your changes are covered by tests, so that we don't break it unintentionally in the future.
6. Create a new pull request.

## License

Released under the [MIT License](http://www.opensource.org/licenses/MIT). Copyright (c) 2015-2024 Ministry of Justice.
