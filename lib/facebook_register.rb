class FacebookRegister < Sinatra::Base
  get '/unauthenticated' do
    User.new.register(params["code"])#.save
    redirect '/index'
  end
end
