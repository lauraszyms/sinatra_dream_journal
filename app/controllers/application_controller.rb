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

  get "/login" do
    if !User.exists?(session[:user_id])
      erb :'/users/login'
    else
      redirect "/dreams"
    end
  end

  post "/login" do
   @user = User.find_by(:username => params[:username])

   if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/dreams"
   else
      redirect "/signup"
   end
  end

  get "/logout" do
    if !User.exists?(session[:user_id])
      redirect "/"
    else
      session.clear
      redirect "/login"
    end
  end

  get '/dreams/new' do
    if logged_in?
     erb :'/tweets/create_tweet'
    else
     redirect "/login"
   end
  end


end
