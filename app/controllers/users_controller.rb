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
      erb :'/users/signup', locals: { message: 'Must have a valid username or password!' }
    elsif User.find_by(username: params[:username]) != nil
      #db.conn("SELECT * FROM users WHERE username = 'Andrew' LIMIT 1")
      #=> nil
      erb :'/users/signup', locals: { message: 'Username is already taken!' }
    else
      @user = User.new(:username => params[:username], :password => params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}?message=success"
      else
        erb :'/users/signup', locals: { message: @user.errors.full_messages.to_sentence }
      end
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    @dreams = @user.dreams
    binding.pry
    @sorted_dreams = @dreams.order(hours_slept: :desc)
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
