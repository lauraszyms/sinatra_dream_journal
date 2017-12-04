class UsersController < ApplicationController


  get "/signup" do
    if !User.exists?(session[:user_id])
      erb :'/users/signup'
    else
      @user = current_user
      redirect "/users/#{current_user.id}"
   end
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == ""
      erb :'/users/invalid'
    elsif User.find_by(username: params[:username]) != nil
      erb :'/users/username_taken'
    else
      @user = User.new(:username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
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
      redirect "/users/#{@user.id}"
   else
      erb :'/users/invalid'
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



end
