require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do 
    "Welcome to Fwitter"
  end 
  
  get '/signup' do 
    erb :'users/signup'
  end 
  
  post '/signup' do
    if params[:username]=="" || params[:email]=="" || params[:password]==""
      redirect '/signup'
    else 
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      redirect '/tweets'
    end 
  end
  
  
  get '/login' do 
    erb :'users/login'
  end 
  
  post '/login' do
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      redirect '/tweets'
    else
      redirect 'users/login'
    end
    
  end 

end
