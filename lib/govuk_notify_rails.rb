require 'action_mailer'
require 'notifications/client'

Dir[File.dirname(__FILE__) + '/govuk_notify_rails/*.rb'].each { |file| require file }

module GovukNotifyRails
end
