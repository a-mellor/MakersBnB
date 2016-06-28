require 'data_mapper'


class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, Text
  property :price, Integer
  property :available_from, Date
  property :available_until, Date

end
