3.0.0 (08/08/2024)
==================

* Updated to use latest version of the `notifications-ruby-client` gem (currently [6.2](https://github.com/alphagov/notifications-ruby-client/blob/main/CHANGELOG.md#620)). PR contributed by @stephencdaly.
* Added support for [one-click unsubscribe URLs](https://docs.notifications.service.gov.uk/ruby.html#one-click-unsubscribe-url-optional). 
The one-click unsubscribe URL will be added to the headers of your email. Email clients will use it to add an unsubscribe button.

Please note starting with version 6.0 of the client, some breaking changes were introduced to the `prepare_upload` method. 
Although this gem does not use this method directly, given the `notifications-ruby-client` gem is a transitive dependency, 
if you are using `prepare_upload` in your code make sure you've made the [necessary changes](https://github.com/alphagov/notifications-ruby-client/blob/main/CHANGELOG.md#600) 
before updating to this version.

2.2.0 (07/10/2021)
==================

* Support sending a single mail to multiple recipients. PR contributed by @thomasleese.

2.1.2 (22/01/2020)
==================

* Guard against future backwards-incompatible versions of the `notifications-ruby-client` dependency by using a pessimistic constraint operator. PR contributed by @frankieroberto.

2.1.1 (10/09/2019)
==================

* Added an optional `#set_email_reply_to` method to provide the UUID of the email address to use as `reply_to`. If no 
email_reply_to is specified, the default email reply to address will be used. PR contributed by @MatthewBurstein.

2.1.0 (22/11/2018)
==================

* Updated to use version 2.9.0 of the `notifications-ruby-client` gem, with support for file uploads.
* After delivery, the `message` object now also holds the `Notifications::Client:ResponseNotification` for inspection. 
For example this can be used to store in your database the Notification UUID of the email just sent.
* Tests should now pass also when using Rails 5.x

2.0.0 (24/02/2017)
==================

* Updated to use version 2.0.0 of the `notifications-ruby-client` gem
* It is no longer necessary to expose the `service_id` environment variable, as only the `api_key` is needed.
* Added a `set_reference()` method. The reference can be used as a unique reference for the notification. It is optional and Notify does not require this reference to be unique.

1.0.0 (31/08/2016)
==================

* Removed `notifications-ruby-client` gem from the Gemfile, as it is now released to RubyGems.

0.0.2 (26/08/2016)
==================

* Initial release.
