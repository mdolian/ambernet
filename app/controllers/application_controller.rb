class ApplicationController < ActionController::Base

  before_filter do 
    logger.info "USER: #{warden.user} #{warden.authenticated?}" 
    logger.info "#{AppConfig.facebook_app_id}"
  end

end
