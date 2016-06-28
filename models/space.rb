require 'data_mapper'


class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :description, Text, required: true
  property :price, Integer, required: true
  property :available_from, Date
  property :available_until, Date

  belongs_to :user
  
end
