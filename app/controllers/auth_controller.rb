class AuthController < ApplicationController

  before_filter :authenticate_admin!
  
  def client  
    OAuth2::Client.new(AppConfig.fb_api_key, AppConfig.fb_api_secret, :site => 'https://graph.facebook.com')  
  end  

  def facebook
    redirect_to client.web_server.authorize_url(  
      :redirect_uri => redirect_uri,   
      :scope => 'email,offline_access'  
    )  
  end  

  def facebook_callback  
    access_token = client.web_server.get_access_token(params[:code], :redirect_uri => redirect_uri)  
    user = JSON.parse(access_token.get('/me'))  

    user.inspect  
    logger.info "User: #{user.to_s}"
    redirect_to '/index'
  end  

  def redirect_uri  
    uri = URI.parse(request.url)  
    uri.path = '/auth/facebook/callback'  
    uri.query = nil  
    uri.to_s  
  end
  
  def login
    render
  end

end
