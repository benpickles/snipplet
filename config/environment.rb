RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'addressable', :lib => 'addressable/uri'
  config.gem 'authlogic'

  config.frameworks -= [:active_resource, :action_mailer]

  config.time_zone = 'UTC'
end
