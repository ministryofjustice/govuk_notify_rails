$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'govuk_notify_rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'govuk_notify_rails'
  s.version     = GovukNotifyRails::VERSION
  s.authors     = ['Jesus Laiz']
  s.email       = ['zheileman@users.noreply.github.com']
  s.homepage    = 'https://github.com/ministryofjustice/govuk_notify_rails'
  s.summary     = 'Custom ActionMailer delivery method for sending emails via GOV.UK Notify API'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '>= 4.1.0'
  s.add_dependency 'notifications-ruby-client', '>= 2.9.0'

  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'listen', '~> 3.0.5'
end
