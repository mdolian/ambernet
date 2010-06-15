class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def facebook_callback  
    redirect_to '/index'
  end
  
  def login
    redirect_to '/index'
  end  
  
end
