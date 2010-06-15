class UsersController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:logout]
  
  def facebook_callback  
    redirect_to '/index'
  end
  
  def login
    logger.info "USER: #{user_session}"
    redirect_to '/index'
  end
  
  def logout
    sign_out :user
    logger.info "USER: #{user_session}"    
    redirect_to '/index'
  end
  
end
