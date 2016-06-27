require 'sinatra/base'

require_relative 'data_mapper_setup'
require_relative 'models/space'

class MakersBnB < Sinatra::Base
  get '/' do
    'Hello MakersBnB!'
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'spaces/list'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
