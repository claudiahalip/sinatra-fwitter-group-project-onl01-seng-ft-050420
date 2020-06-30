class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user=current_user
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect "/login"
    end 
  end 
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect "/login"
    end 
  end
  
  post '/tweets' do
    if params[:content].empty?
      redirect to "/tweets/new"
    else
      user = current_user
      user.tweets.create(content: params[:content])
    end 
  end 
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(id: params[:id])
      erb :'tweets/show'
    else
      redirect "/login"
    end 
  end 
  
  get '/tweets/:id/edit' do 
    if logged_in? &&  @tweet = current_user.tweets.find_by_id(id: params[:id])
      erb :'tweets/edit'
    else 
      redirect "/login"
    end
  end 
  
  
  patch '/tweets/:id' do 
    tweet = Tweet.find_by_id(id: params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{tweet.id}/edit"
    else 
      tweet.update(content: params[:content])
      tweet.save
    end 
  end
  
  delete 'tweets/:id/delete' do 
    tweet = Tweet.find_by(params[:id])
    tweet.destroy if tweet.user == current_user
    redirect "/tweets"
  end 
  
end


