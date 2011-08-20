require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require :default, Rails.env

module Ambernet
  class Application < Rails::Application

    config.plugins = [ :all ]

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework  :test_unit, :fixture => true
    end  
    
    config.middleware.insert_after ActionDispatch::Head, Rack::Hoptoad, "8f35f072dd38fab1566cc09cb8e48304"
    #config.middleware.insert_after Rack::Hoptoad, FacebookRegister

    config.session_store :cookie_store, { :key => "_ambernet_session" }
    config.secret_token = "KLSD84KLF8QIOEUF03Q40980934809F890AFSD890ASFD890SAD8F90A0S-8D089-FADS809-SADF"
    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters << :password
    
  end
end
