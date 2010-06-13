Devise.setup do |config|
  config.mailer_sender = "admin@ambernetonline.net"

  require 'devise/orm/active_record'

  config.use_default_scope = true
  config.default_scope = :user
  
  config.warden do |manager|      
    manager.failure_app = FacebookRegister
    manager[:facebook_secret] = AppConfig.fb_api_secret
    manager[:facebook_client_id] = AppConfig.fb_api_key
    manager[:facebook_callback_url] = AppConfig.fb_callback_url
    manager.default_strategies(:scope => :user).unshift :facebook 
  end
end
