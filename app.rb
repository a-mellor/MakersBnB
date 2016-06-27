ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require_relative 'models/user'

class MakersBnB < Sinatra::Base
  get '/' do
    redirect '/users/new'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    User.create(email: params[:email],
                password: params[:password])
    redirect '/spaces'
  end

  get '/spaces' do
    erb :'spaces/spaces'
  end

  run! if app_file == $0
end
