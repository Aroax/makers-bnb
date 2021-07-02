require_relative "database_connection"

class Booking
  attr_reader :id, :customer_id, :space_id, :request, :date_in, :date_out

  def self.add(customer_id:, space_id:, date_in:, date_out:)
    request = "pending"
    result = DatabaseConnection.query(sql: "INSERT INTO booking (customer_id, space_id, request, date_in, date_out) VALUES ($1, $2, $3, $4, $5) RETURNING id, customer_id, space_id, request, date_in, date_out;", params: [customer_id, space_id, request, date_in, date_out])
    booking = Booking.new(id: result[0]["id"], customer_id: result[0]["customer_id"], space_id: result[0]["space_id"], request: result[0]["request"], date_in: result[0]["date_in"], date_out: result[0]["date_out"])
  end

  def self.find_by_space_id(space_id:)
    bookings = DatabaseConnection.query(sql: "SELECT * FROM booking WHERE space_id=$1;", params: [space_id])
    booking = bookings.map do |booking|
      Booking.new(id: booking["id"], customer_id: booking["customer_id"], space_id: booking["space_id"], request: booking["request"], date_in: booking["date_in"], date_out: booking["date_out"])
    end
    booking.first
  end

  def self.find_by_customer_id(customer_id:)
    bookings = DatabaseConnection.query(sql: "SELECT * FROM booking WHERE customer_id=$1;", params: [customer_id])
    bookings.map do |booking|
      Booking.new(id: booking["id"], customer_id: booking["customer_id"], space_id: booking["space_id"], request: booking["request"], date_in: booking["date_in"], date_out: booking["date_out"])
    end
  end

  def self.find_id(customer_id:, space_id:)
    bookings = DatabaseConnection.query(sql: "SELECT * FROM booking WHERE space_id=$1 AND customer_id=$2;", params: [space_id, customer_id])
    booking = bookings.map do |booking|
      Booking.new(id: booking["id"], customer_id: booking["customer_id"], space_id: booking["space_id"], request: booking["request"], date_in: booking["date_in"], date_out: booking["date_out"])
    end
    booking.first
  end

  # def self.sort_bookings_by_role(customer_id:, role:)
  #   @host = []
  #   @guest = []
  #
  #   bookings = Booking.find_by_customer_id(customer_id: customer_id)
  #
  #   owned_spaces = Space.find_by_customer_id(customer_id: customer_id)
  #   owned_space_ids = []
  #
  #   owned_spaces.each { |space| owned_space_ids << space.id }
  #
  #   bookings.each do |booking|
  #
  #     if owned_space_ids.include?(booking.space_id)
  #       @host << booking.first
  #     else
  #       @guest << booking.first
  #     end
  #   end
  #
  #   return @host if role == "host"
  #   return @guest if role == "guest"
  # end


  # def self.sort_bookings_by_request(booking_array:)
  #   pending = []
  #   approved = []
  #   declined = []
  #
  #   booking_array.each { |booking|
  #
  #   if booking.request == "pending"
  #     pending << booking
  #   elsif booking.request == "approved"
  #     approved << booking
  #   else
  #     declined << booking
  #   end
  #
  #   }
  #
  #   pending.each do |booking|
  #     booking.
  #
  #  return pending, approved, declined
  #
  # end

  def self.last(customer_id:)
    result = DatabaseConnection.query(sql: "SELECT * FROM booking WHERE customer_id=$1 ORDER BY id DESC LIMIT 1;", params: [customer_id])

    recent_booking = result.map do |booking|
      Booking.new(id: booking["id"], customer_id: booking["customer_id"], space_id: booking["space_id"], request: booking["request"], date_in: booking["date_in"], date_out: booking["date_out"])
    end
    recent_booking.first
  end

  def initialize(id:, customer_id:, space_id:, request:, date_in:, date_out:)
    @id = id
    @customer_id = customer_id
    @space_id = space_id
    @request = request
    @date_in = date_in
    @date_out = date_out
  end

  def self.available?(space_id:, date_in:)
    bookings_for_space_id = DatabaseConnection.query(sql: "SELECT * FROM booking WHERE space_id=$1 AND date_in=$2;", params: [space_id, date_in])
    result = bookings_for_space_id.map do |booking|
      Booking.new(id: booking["id"], customer_id: booking["customer_id"], space_id: booking["space_id"], request: booking["request"], date_in: booking["date_in"], date_out: booking["date_out"])
    end
    result.empty?
  end

  def self.approve(booking_id:)
    DatabaseConnection.query(sql:"UPDATE booking SET request = $1 WHERE id = $2;", params: ["approved", booking_id])
  end

  def self.decline(booking_id:)
    DatabaseConnection.query(sql:"UPDATE booking SET request = $1 WHERE id = $2;", params: ["declined", booking_id])
  end

end
