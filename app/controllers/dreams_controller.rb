class DreamsController < ApplicationController

 get '/dreams/new' do
    if logged_in?
     @user = current_user
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
    @user = current_user
    @dreams = Dream.all
    erb :'/dreams/dreams'
   else
    redirect "/login"
   end
  end

  get '/dreams/:id'do
   if logged_in?
    @dream = Dream.find(params[:id])
    erb :'dreams/show_dream'
   else
    redirect "/login"
   end
  end

  post '/dreams/:id/edit' do
   @dream = Dream.find(params[:id])
   if logged_in? && @dream.user_id == current_user.id
    erb :'dreams/edit'
   else
    redirect "/login"
   end
  end

  patch '/dreams/:id' do
   @dream = Dream.find(params[:id])
   if params[:summary] == ""
    redirect "/dreams/#{params[:id]}/edit"
   else
    @dream.update(date: params[:date], keywords: params[:keywords], hours_slept: params[:hours_slept], lucid_dream?: params[:lucid_dream?], summary: params[:summary])
    redirect "/dreams/#{params[:id]}"
   end
  end

  delete '/dreams/:id/delete' do
   @dream = Dream.find(params[:id])
   @user = current_user
   if logged_in? && @dream.user_id == @user.id
    @dream.delete
    erb :'/dreams/delete'
   else
    redirect "/login"
   end
  end



end
