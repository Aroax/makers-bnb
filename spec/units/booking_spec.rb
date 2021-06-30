require 'booking'
require 'database_connection'
require 'time'
require 'pg'

describe Booking do
  # let(:connection) { PG.connect(dbname: 'makers_bnb_test') }
  let(:customer_id) { 1 }
  let(:space_id) { 1 }
  let(:request) { "approved" }
  let(:date_in) { Date.parse('2021-09-03') }
  let(:date_out) { Date.parse('2021-09-10') }

  describe '.add' do

    it 'adds a request to book' do
      request = Booking.add(space_id: space_id)
      booking = Booking.find_by_space_id(space_id: space_id)

      expect(request.space_id).to eq booking.first.space_id

    end
  end

  describe '.find_by_space_id' do
    it 'returns bookings matching a given space id' do
      DatabaseConnection.query(sql: "INSERT INTO booking (customer_id, space_id, request, date_in, date_out) VALUES ($1, $2, $3, $4, $5);", params: [customer_id, space_id, request, date_in, date_out])
      booking = Booking.find_by_space_id(space_id: space_id)

      expect(booking.first.customer_id).to eq "#{customer_id}"
      expect(booking.first.space_id).to eq "#{space_id}"
      expect(booking.first.request).to eq "#{request}"
      expect(booking.first.date_in).to eq "#{date_in}"
      expect(booking.first.date_out).to eq "#{date_out}"
    end
  end

end
