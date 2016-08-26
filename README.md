# GovukNotifyRails

Custom ActionMailer delivery to send emails via the API client for GOV.UK Notify.

## Installation

Prior to usage an account must be created through the Notify admin console. This will provide the API credentials needed in you application.

You can then install the gem or require it in your application.

```ruby
gem 'govuk_notify_rails'
```

Please note the `notifications-ruby-client` gem has not been released yet to RubyGems so there needs to be a reference to the git repository in your Gemfile. This will not be necessary and this dependency will be added to the gemspec once said gem is released to RubyGems.

```ruby
gem 'notifications-ruby-client', '~> 0.0.1', git: 'https://github.com/alphagov/notifications-ruby-client.git'
```

In your app, you will need to add the delivery method, and set the `service_id` and `secret_key`, for example with an initializer:

```ruby
ActionMailer::Base.add_delivery_method :govuk_notify, GovukNotifyRails::Delivery,
  service_id: ENV['GOVUK_NOTIFY_SERVICE_ID'],
  secret_key: ENV['GOVUK_NOTIFY_API_SECRET']
```

## Usage

To send emails through GOV.UK Notify, create your mailers like usual but inheriting from `GovukNotifyRails::Mailer`. Then just use `mail()` as with any other ActionMailer passing the recipient email.

The template ID is mandatory, but the personalisation is optional.

```ruby
class NotifyMailer < GovukNotifyRails::Mailer
  #
  # Define methods as usual, and set the template and personalisation accordingly
  #
  def my_test_email(user)
    set_template('9661d08a-486d-4c67-865e-ad976f17871d')
    
    set_personalisation(
      full_name: user.full_name,
      address: user.address
    )
    
    mail(to: user.email)
  end
end

```

### Mailer previewing

You can also create mailer previews as usual. The preview will however be a sample string as the actual template is hosted in the GOV.UK Notify website.

For example:

```ruby
class NotifyMailerPreview < ActionMailer::Preview
  
  def my_test_email
    user = User.fist
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

Released under the [MIT License](http://www.opensource.org/licenses/MIT). Copyright (c) 2015-2016 Ministry of Justice.