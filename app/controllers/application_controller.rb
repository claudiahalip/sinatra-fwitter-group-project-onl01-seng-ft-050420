require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret,  'top_session'
  end
  
  get '/' do 
    "Welcome to Fwitter"
  
  end 
  
  get '/signup' do 
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end 
  end 
  
  post '/signup' do
    if params[:username]=="" || params[:email]=="" || params[:password]==""
      redirect '/signup'
    else 
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id]=@user.id
      redirect '/tweets'
    end 
    
  end
  
  
  get '/login' do 
    if logged_in?
      erb :'tweets/index'
    else
      erb :'users/login'
    end 
  end 
  
  post '/login' do
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id]=@user.id
      redirect '/tweets'
    else
      redirect '/'
    end
  end 
  
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect  '/tweets'
    else
      redirect '/login'
    end
  end 

  helpers do 
    def logged_in?
      !!session[:user_id]
    end 
    
    def current_user 
      @current_user ||= User.find_by(session[:user_id])
    end 
  end 
  
  get '/failure' do
    erb :failure
  end
end
