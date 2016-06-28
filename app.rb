ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'models/user'

require_relative 'data_mapper_setup'
require_relative 'models/space'

class MakersBnB < Sinatra::Base

  register Sinatra::Flash
  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    redirect '/spaces' if current_user
    redirect '/users/new'
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect '/spaces'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'spaces/list'
  end

  get '/spaces/new' do
    redirect '/' unless current_user
    erb :'spaces/new'
  end

  post '/spaces' do
    space = Space.new(params)
    space.user_id = current_user.id
    space.save
    redirect '/spaces'
  end

  run! if app_file == $0
end
