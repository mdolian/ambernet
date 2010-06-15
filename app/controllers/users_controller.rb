class UsersController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:logout]
  
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
