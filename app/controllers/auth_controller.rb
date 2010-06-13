class AuthController < ApplicationController
  
  def facebook_callback  
    redirect_to '/index'
  end  

end
