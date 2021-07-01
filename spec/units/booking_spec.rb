require 'booking'
require 'database_connection'
require 'time'
require 'pg'

describe Booking do
  # let(:connection) { PG.connect(dbname: 'makers_bnb_test') }
  let(:customer_id) { 666 }
  let(:space_id) { 1 }
  let(:request) { "approved" }
  let(:date_in) { Date.parse('2021-09-03') }
  let(:date_out) { Date.parse('2021-09-10') }

  describe '.add' do

    it 'adds a request to book' do
      request = Booking.add(space_id: space_id, customer_id: customer_id)
      booking = Booking.find_by_space_id(space_id: space_id)

      expect(request.space_id).to eq booking.space_id

    end
  end

  describe '.find_by_space_id' do
    it 'returns bookings matching a given space id' do
      DatabaseConnection.query(sql: "INSERT INTO booking (customer_id, space_id, request, date_in, date_out) VALUES ($1, $2, $3, $4, $5);", params: [customer_id, space_id, request, date_in, date_out])
      booking = Booking.find_by_space_id(space_id: space_id)

      expect(booking.customer_id).to eq "#{customer_id}"
      expect(booking.space_id).to eq "#{space_id}"
      expect(booking.request).to eq "#{request}"
      expect(booking.date_in).to eq "#{date_in}"
      expect(booking.date_out).to eq "#{date_out}"
    end
  end

  describe '.last' do
    it 'returns the most recent booking request sent' do
      DatabaseConnection.query(sql: "INSERT INTO booking (customer_id, space_id, request, date_in, date_out) VALUES ($1, $2, $3, $4, $5);", params: [customer_id, 2, request, date_in, date_out])
      DatabaseConnection.query(sql: "INSERT INTO booking (customer_id, space_id, request, date_in, date_out) VALUES ($1, $2, $3, $4, $5);", params: [customer_id, space_id, request, date_in, date_out])
      booking = Booking.last(customer_id: customer_id)

      expect(booking.customer_id).to eq "#{customer_id}"
      expect(booking.space_id).to eq "#{space_id}"
      expect(booking.request).to eq "#{request}"
      expect(booking.date_in).to eq "#{date_in}"
      expect(booking.date_out).to eq "#{date_out}"
    end
  end

  describe '.find_by_customer_id' do
    it 'returns all customer bookings' do
      DatabaseConnection.query(sql: "INSERT INTO booking (customer_id, space_id, request, date_in, date_out) VALUES ($1, $2, $3, $4, $5);", params: [customer_id, space_id, request, date_in, date_out])
      DatabaseConnection.query(sql: "INSERT INTO booking (customer_id, space_id, request, date_in, date_out) VALUES ($1, $2, $3, $4, $5);", params: [customer_id, 2, request, date_in, date_out])
      DatabaseConnection.query(sql: "INSERT INTO booking (customer_id, space_id, request, date_in, date_out) VALUES ($1, $2, $3, $4, $5);", params: [customer_id, 3, request, date_in, date_out])

      customer_bookings = Booking.find_by_customer_id(customer_id: customer_id)

      expect(customer_bookings.length).to eq 3
      expect(customer_bookings.first).to be_a Booking
      expect(customer_bookings.first.customer_id).to eq "#{customer_id}"
      expect(customer_bookings.first.space_id).to eq "#{space_id}"
      expect(customer_bookings.first.request).to eq "#{request}"
      expect(customer_bookings.first.date_in).to eq "#{date_in}"
      expect(customer_bookings.first.date_out).to eq "#{date_out}"
    end
  end

end
