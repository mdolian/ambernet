Devise.setup do |config|
  config.mailer_sender = "admin@ambernetonline.net"

  require 'devise/orm/active_record'

  config.use_default_scope = true
  config.default_scope = :user
  
  #config.warden do |manager|
  #  manager.failure_app = FailureApp
  #  manager.oauth2(:facebook) do |facebook|
  #    facebook.consumer_secret = AppConfig.fb_api_secret
  #    facebook.consumer_key  = AppConfig.fb_api_key
  #    facebook.options :site => 'https://graph.facebook.com'
  #  end
  #  config.default_strategies(:facebook_oauth2, :password, :other)
  #end  
  
end
