require_relative "database_connection"

class Request
  attr_reader :customer_id, :space_id, :space_name, :date_in, :date_out, :hero_image, :request_status

  def self.dashboard(customer_id: )
    result = DatabaseConnection.query(sql: "SELECT customer.id AS customer_id,booking.space_id AS space_id,space.name AS space_name,space.description AS space_description,booking.date_in AS date_in,booking.date_out AS date_out,space.hero_image AS hero_image,booking.request AS request FROM booking JOIN customer ON booking.customer_id=customer.id JOIN space ON booking.space_id=space.id WHERE customer.id=$1;", params: [customer_id])
    p result
    # most recent query string: SELECT customer.id AS customer_id, booking.space_id AS space_id, space.name AS space_name, booking.date_in AS date_in, booking.date_out AS date_out, space.hero_image AS hero_image, booking.request AS request FROM customer WHERE id=$1 JOIN booking ON customer.id=booking.customer_id JOIN space ON booking.space_id=space.id;
    # DatabaseConnection.query(sql: "SELECT customer.id, booking.space_id, space.name, booking.date_in, booking.date_out, space.hero_image, booking.request FROM customer JOIN booking ON customer.id=booking.customer_id JOIN space ON booking.space_id=space.id;", params: [])
    result.map do |request|
      Request.new(
        customer_id: result[0]["customer_id"],
        space_id: result[0]["space_id"],
        space_name: result[0]["space_name"],
        date_in: result[0]["date_in"],
        date_out: result[0]["date_out"],
        hero_image: result[0]["hero_image"],
        request_status: result[0]["request"]
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
