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

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect "/signup"
    else
      @user = User.new(:username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/dreams"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/profile'
  end


end
