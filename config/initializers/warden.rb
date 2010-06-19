Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.failure_app = FacebookRegister
  manager[:facebook_secret] = AppConfig.facebook_api_secret
  manager[:facebook_client_id] = AppConfig.facebook_api_key
  manager[:facebook_callback_url] = AppConfig.facebook_callback_url
  manager[:facebook_scopes] = 'email,offline_access'
  manager.default_strategies :facebook
end

# Setup Session Serialization
class Warden::SessionSerializer
  def serialize(record)
    [record.class, record.id]
  end

  def deserialize(keys)
    klass, id = keys
    klass
  end
end
