class UsersController < ApplicationController
  
  before_filter :login_required, :except => [:logout]
  
  def login_required
    if !warden.authenticated?
      warden.authenticate! params
    end
  end
  
  def facebook_callback  
    redirect_to '/index'
  end
  
  def login
    redirect_to '/index'
  end
  
  def logout
    warden.logout
    redirect_to '/index'
  end
  
end
