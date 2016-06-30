ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'

require_relative 'data_mapper_setup'

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

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/spaces'
    else
      flash.keep[:notice] = "Incorrect log in details. Please try again."
      redirect '/sessions/new'
    end
  end

  get '/sessions/end' do
    session.clear
    redirect '/'
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
    if space.save
      redirect '/spaces'
    else
      flash.keep[:errors] = space.errors.full_messages
      redirect '/spaces/new'
    end
  end

  get '/spaces/details/:id' do
    @current_space = Space.first(id: params[:id])
    erb :'spaces/details'
  end

  post '/requests' do
    @booking_request = Request.new(check_in_date: params[:check_in_date])
    @booking_request.user_id = current_user.id
    @booking_request.space_id = params[:space_id]
    if @booking_request.save
      redirect '/requests'
    else
      flash.keep[:errors] = @booking_request.errors.full_messages
      redirect "/spaces/details/#{@booking_request.space_id}"
    end
  end

  get '/requests' do
    @requested_data = Request.all(user_id: current_user.id)
    @requested_spaces = []
    @requested_data.each do |my_request|
      @requested_spaces << Space.first(id: my_request.space_id)
    end


    erb :'requests'
  end

  run! if app_file == $0
end
