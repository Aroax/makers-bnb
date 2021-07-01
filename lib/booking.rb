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
end
