class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :lockable, :timeoutable and :activatable
  #devise 

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :access_token

#  has n, :have_lists
#  has n, :sources, :through => :have_lists
#  has n, :wish_lists
#  has n, :recordings, :thorough => :wish_lists

  scope :by_access_token, lambda { |access_token|
    where("access_token = ?", access_token)
  }
  
  def register(code)
    client = OAuth2::Client.new(AppConfig.facebook_api_key, AppConfig.facebook_api_secret, :site => 'https://graph.facebook.com')
    access_token = client.web_server.get_access_token(code, :redirect_uri => "#{AppConfig.host}#{AppConfig.facebook_callback_url}")  
    user = JSON.parse(access_token.get('/me'))
    self.id, self.access_token, self.email = user['id'], access_token.token, "not@entered.yet"
    self
  end
end
