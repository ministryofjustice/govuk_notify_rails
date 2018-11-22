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
