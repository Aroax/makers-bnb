require_relative "database_connection"

class Request
  attr_reader :customer_id, :space_id, :space_name, :date_in, :date_out, :hero_image, :request_status

  def self.dashboard
    result = DatabaseConnection.query(sql: "SELECT * FROM customer INNER JOIN booking ON customer.id=booking.customer_id INNER JOIN space ON booking.space_id=space.id;", params: [])
    p result
    # customer.id, booking.space_id, space.name, booking.date_in, booking.date_out, space.hero_image, booking.request
    # DatabaseConnection.query(sql: "SELECT customer.id, booking.space_id, space.name, booking.date_in, booking.date_out, space.hero_image, booking.request FROM customer JOIN booking ON customer.id=booking.customer_id JOIN space ON booking.space_id=space.id;", params: [])
    result.map do |request|
      Request.new(
        customer_id: result[0]["id"],
        space_id: result[0]["space_id"],
        price: result[0]["price"],
        space_name: result[0]["name"],
        date_in: result[0]["date_in"],
        date_out: result[0]["date_out"],
        hero_image: result[0]["hero_image"],
        request_status: result[0]["request"]
      )
    end
  end

  def initialize(customer_id:,space_id:,space_name:,date_in:,date_out:,hero_image:,request_status:, price:)
    @customer_id = customer_id
    @space_id = space_id
    @space_name = space_name
    @date_in = date_in
    @date_out = date_out
    @hero_image = hero_image
    @request_status = request_status
    @price = price
  end

end
