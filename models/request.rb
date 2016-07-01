class Request
  include DataMapper::Resource

  property :id, Serial
  property :check_in_date, Date, required: true
  property :confirmed, Boolean, required: true, :default => false

  belongs_to :space
  belongs_to :user

  validates_with_method :check_in_date, :method => :is_within_available_dates?
  validates_with_method :confirmed, :method => :is_booking_already_confirmed?




  private

  def is_within_available_dates?
    return true if @check_in_date == ''
    if (@check_in_date > space.available_from && @check_in_date < space.available_until)
      true
    else
      [false, 'Check in date must be within available dates']
    end
  end

  def is_booking_already_confirmed?
    requests_to_check = Request.all(space_id: @space_id, check_in_date: @check_in_date)
    requests_to_check.each do |single_request|
      return [false, "The space has already been booked for this date"] if single_request.confirmed
    end
    true
  end

end
