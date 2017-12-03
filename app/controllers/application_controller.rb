class ApplicationController < Sinatra::Base
    configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
   erb :index
  end

  get "/signup" do
    if !User.exists?(session[:user_id])
      erb :'/users/signup'
    else
      redirect "/dreams"
   end
  end


end
