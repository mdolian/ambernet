# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.frameworks -= [ :active_record ]

  dm_gems_version = "0.9.11"
  do_gems_version = "0.9.12"

  config.gem "dm-core", :version => dm_gems_version
  config.gem "do_mysql", :version => do_gems_version
  config.gem "data_objects", :version => do_gems_version
  config.gem "dm-aggregates", :version => dm_gems_version
  config.gem "dm-migrations", :version => dm_gems_version  
  config.gem "dm-timestamps", :version => dm_gems_version
  config.gem "dm-types", :version => dm_gems_version
  config.gem "dm-validations", :version => dm_gems_version
  config.gem "dm-serializer", :version => dm_gems_version 
  config.gem "rails_datamapper", :version => dm_gems_version   
  config.gem "haml"
  config.gem "hpricot"
  config.gem "rubyzip", :lib => "zip/zip"
  config.gem "will_paginate"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  config.time_zone = 'UTC'

end