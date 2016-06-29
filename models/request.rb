class Request
  include DataMapper::Resource

  property :id, Serial
  property :check_in_date, Date, required: true

belongs_to :space
belongs_to :user

end