require_relative "database_connection"

class Request
  attr_reader :customer_id, :space_id, :space_name, :date_in, :date_out, :hero_image, :request_status

  def self.dashboard
    result = DatabaseConnection.query(sql: "SELECT customer.id, booking.space_id, space.name, booking.date_in, booking.date_out, space.hero_image, booking.request FROM customer JOIN booking ON customer.id=booking.customer_id JOIN space ON booking.space_id=space.id;", params: [])
    p result
    # DatabaseConnection.query(sql: "SELECT customer.id, booking.space_id, space.name, booking.date_in, booking.date_out, space.hero_image, booking.request FROM customer JOIN booking ON customer.id=booking.customer_id JOIN space ON booking.space_id=space.id;", params: [])
    result.map do |request|
      Request.new(
        customer_id: result[0]['id'],
        space_id: result[0]['booking.space_id'],
        space_name: result[0]['space.name'],
        date_in: result[0]['booking.date_in'],
        date_out: result[0]['booking.date_out'],
        hero_image: result[0]['space.hero_image'],
        request_status: result[0]['booking.request']
      )
    end
  end

  def initialize(customer_id:,space_id:,space_name:,date_in:,date_out:,hero_image:,request_status:)
    @customer_id = customer_id
    @space_id = space_id
    @space_name = space_name
    @date_in = date_in
    @date_out = date_out
    @hero_image = hero_image
    @request_status = request_status
  end

end
