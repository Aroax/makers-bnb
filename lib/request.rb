require_relative "database_connection"
require_relative "space"

class Request
  attr_reader :customer_id, :space_id, :space_name, :space_owner_id, :date_in, :date_out, :hero_image, :request_status, :space_city

  def self.dashboard(customer_id: )
    result = DatabaseConnection.query(sql: "SELECT customer.id AS customer_id,booking.space_id AS space_id,space.name AS space_name,space.customer_id AS space_owner_id,space.city AS space_city,space.description AS space_description,booking.date_in AS date_in,booking.date_out AS date_out,space.hero_image AS hero_image,booking.request AS request FROM booking JOIN customer ON booking.customer_id=customer.id JOIN space ON booking.space_id=space.id WHERE customer.id=$1;", params: [customer_id])
    # p result
    i = 0
    # length = result.count
    # most recent query string: SELECT customer.id AS customer_id, booking.space_id AS space_id, space.name AS space_name, booking.date_in AS date_in, booking.date_out AS date_out, space.hero_image AS hero_image, booking.request AS request FROM customer WHERE id=$1 JOIN booking ON customer.id=booking.customer_id JOIN space ON booking.space_id=space.id;
    # DatabaseConnection.query(sql: "SELECT customer.id, booking.space_id, space.name, booking.date_in, booking.date_out, space.hero_image, booking.request FROM customer JOIN booking ON customer.id=booking.customer_id JOIN space ON booking.space_id=space.id;", params: [])
    requests = []
    result.map do |request|
      while i < result.count
        object = Request.new(
          customer_id: result[i]["customer_id"],
          space_id: result[i]["space_id"],
          space_name: result[i]["space_name"],
          space_owner_id: result[i]["space_owner_id"],
          date_in: result[i]["date_in"],
          date_out: result[i]["date_out"],
          hero_image: result[i]["hero_image"],
          request_status: result[i]["request"],
          space_city: result[i]["space_city"]
        )
        i += 1
        requests << object
      end
    end
    return requests
  end

  def self.categorize(dashboard:)
    host_requests = []
    guest_requests = []

    dashboard.each { |request|
      if request.customer_id == request.space_owner_id
        host_requests << request
      else
        guest_requests << request
      end
      }
      # p "hosts - #{host_requests}"
      # p "guests - #{guest_requests}"
    return host_requests, guest_requests
  end

    # host_spaces = Space.find_by_customer_id(customer_id: dashboard[0]["customer_id"])
    # # if no results from this, none of the requests are for owned spaces, therefore all requests are guests
    # if host_spaces.any?
    #   # Iterate over the requests array and sort into two groups; whether the session user owns that space or not
    #   dashboard.map { |request|
    #     if host_spaces.include?(request.space_id)
    #       host_requests << request
    #     else
    #       guest_requests << request
    #     end
    #     }
    # else
    #   guest_requests = dashboard
    # end
    # return host_requests, guest_requests


  def initialize(customer_id:,space_id:,space_name:,date_in:,date_out:,hero_image:,request_status:, space_owner_id:, space_city:)
    @customer_id = customer_id
    @space_id = space_id
    @space_name = space_name
    @space_owner_id = space_owner_id
    @date_in = date_in
    @date_out = date_out
    @hero_image = hero_image
    @request_status = request_status
    @space_city = space_city
  end

end
