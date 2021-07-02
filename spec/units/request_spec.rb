require "database_connection"
require "request"

describe Request do
  it 'returns an array of bookings and spaces for a given customer_id' do
      add_linked_records_to_all_tables
      add_additional_spaces_and_bookings

      customer_bookings = Request.dashboard(customer_id: 1)

      # p customer_bookings

      expect(customer_bookings.length).to eq 3
      expect(customer_bookings.first).to be_a Request
      expect(customer_bookings.first.request_status).to eq "pending"
      expect(customer_bookings.first.space_name).to eq "Dream Test House"
      expect(customer_bookings[1].space_name).to eq "Users Beach House"
      expect(customer_bookings[2].space_name).to eq "Different Users House"
  end

  it 'sorts bookings into hosts and guests' do
    add_linked_records_to_all_tables
    add_additional_spaces_and_bookings

    customer_bookings = Request.dashboard(customer_id: 1)

    host_requests, guest_requests = Request.categorize(dashboard: customer_bookings, current_user: 2)

    expect(customer_bookings.length).to eq 3
    expect(host_requests.length).to eq 2
    expect(guest_requests.length).to eq 1
  end
end
