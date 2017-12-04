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

  get '/dreams/new' do
    if logged_in?
     erb :'/dreams/new'
    else
     redirect "/login"
   end
  end

  post '/dreams' do
   @user = current_user
   if params[:date] == ""
    redirect "/dreams/new"
   else
    @dream = Dream.create(date: params[:date], keywords: params[:keywords], hours_slept: params[:hours_slept], lucid_dream?: params[:lucid_dream?], summary: params[:summary])
    @dream.user_id = @user.id
    @dream.save
    redirect "/dreams/#{@dream.id}"
   end
  end

  get '/dreams' do
   if logged_in?
    @dreams = Dream.all
    erb :'/dreams/dreams'
   else
    redirect "/login"
   end
  end

  get '/dreams/:slug'do
   if logged_in?
    @dream = Dream.find(params[:slug])
    erb :'dreams/show_dream'
   else
    redirect "/login"
   end
  end

  get '/dreams/:slug/edit' do
   if logged_in?
    @dream = Dream.find(params[:slug])
    erb :'dreams/edit'
   else
    redirect "/login"
   end
  end

  patch '/dreams/:slug' do
   @dream = Dream.find(params[:slug])
   if params[:summary] == ""
    redirect "/dreams/#{params[:slug]}/edit"
   else
    @dream.update(summary: params[:summary])
    redirect "/dreams/#{params[:slug]}"
   end
  end

  delete '/dreams/:slug/delete' do
   @dream = Dream.find(params[:slug])
   if logged_in? && @dream.user_id == current_user.id
    @dream.delete
   else
    redirect "/login"
   end
  end

  helpers do
   def logged_in?
    !!session[:user_id]
   end

   def current_user
    User.find(session[:user_id])
   end
  end


end
