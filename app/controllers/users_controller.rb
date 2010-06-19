class UsersController < ApplicationController
  
  before_filter do
    if !warden.authenticated?
      warden.authenticate! params
      logger.info "USER: #{warden.user} #{warden.authenticated?}"     
    end
  end
  
  def facebook_callback  
    redirect_to '/index'
  end
  
  def login
    redirect_to '/index'
  end
  
  def logout
    sign_out :user
    redirect_to '/index'
  end
  
end
