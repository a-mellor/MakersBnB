require 'data_mapper'


class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :description, Text, required: true
  property :price, Integer, required: true
  property :available_from, Date, required: true
  property :available_until, Date, required: true

  validates_with_method :available_from, :method => :is_from_future?

  belongs_to :user

  private
  def is_from_future?
    @available_from = Date.parse("01/01/1900") if @available_from == ""
    if @available_from > Date.today
      true
    else
      [false, "The available from date must be in the future"]
    end
  end

end
