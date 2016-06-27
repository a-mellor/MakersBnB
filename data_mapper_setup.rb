require 'data_mapper'
require 'dm-postgres-adapter'

require_relative 'models/space'

DataMapper.setup(:default, "postgres://localhost/makersbnb_test")
DataMapper.finalize
DataMapper.auto_upgrade!
