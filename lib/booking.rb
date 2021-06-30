require_relative "database_connection"

class Booking
  attr_reader :id, :customer_id, :space_id, :request, :date_in, :date_out

  def self.add(space_id:, date_in:, date_out:)
    # Temporary fixed variables - replace with path dynamic arguments
    customer_id = 1
    request = "approved"
    # date_in = Date.parse("2021-09-03")
    # date_out = Date.parse("2021-09-10")

    result = DatabaseConnection.query(sql: "INSERT INTO booking (customer_id, space_id, request, date_in, date_out) VALUES ($1, $2, $3, $4, $5) RETURNING id, customer_id, space_id, request, date_in, date_out;", params: [customer_id, space_id, request, date_in, date_out])
    booking = Booking.new(id: result[0]["id"], customer_id: result[0]["customer_id"], space_id: result[0]["space_id"], request: result[0]["request"], date_in: result[0]["date_in"], date_out: result[0]["date_out"])
  end

  def self.find_by_space_id(space_id:)
    bookings = DatabaseConnection.query(sql: "SELECT * FROM booking WHERE space_id=$1;", params: [space_id])
    bookings.map do |booking|
      Booking.new(id: booking["id"], customer_id: booking["customer_id"], space_id: booking["space_id"], request: booking["request"], date_in: booking["date_in"], date_out: booking["date_out"])
    end
  end

  def initialize(id:, customer_id:, space_id:, request:, date_in:, date_out:)
    @id = id
    @customer_id = customer_id
    @space_id = space_id
    @request = request
    @date_in = date_in
    @date_out = date_out
  end

  def self.unavailable(space_id:, date_in:)
    bookings_for_space_id = DatabaseConnection.query(sql: "SELECT * FROM booking WHERE space_id=$1;", params: [space_id])
    result = []
    bookings_for_space_id.map do |booking|
      bk = Booking.new(id: booking["id"], customer_id: booking["customer_id"], space_id: booking["space_id"], request: booking["request"], date_in: booking["date_in"], date_out: booking["date_out"])
      if (bk.date_in) == (date_in)
        result << true
      else
        result << false
      end
    end
    return false unless result.include?(true)
    # result.include?(true)
  end
end
