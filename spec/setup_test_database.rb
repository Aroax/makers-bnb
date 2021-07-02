require 'pg'

def connect
connection =  PG.connect(dbname: 'makers_bnb_test')
end

def setup_test_database
  connection = connect
  connection.exec("TRUNCATE booking, customer, message, space;")
  # add_row_to_test_space_table
end

def add_row_to_test_space_table
  description = "lorem ipsum"
  sample_image = "./public/images/placeholder.jpg"
  connection = connect
  connection.exec("INSERT INTO space (id, customer_id, name, description, price, city, hero_image) values ('1', '1', 'Dream Test House', '#{description}', 400, 'london', '#{sample_image}');")
end

def add_second_row_to_test_space_table
  description = "lorem ipsum"
  connection = connect
  sample_image = "./public/images/placeholder.jpg"
  connection.exec("INSERT INTO space (id, customer_id, name, description, price, city, hero_image) values ('2', '1', 'Users Beach House', '#{description}', 400, 'london', '#{sample_image}');")
end

def add_third_row_to_test_space_table
  description = "lorem ipsum"
  connection = connect
  sample_image = "./public/images/placeholder.jpg"
  connection.exec("INSERT INTO space (id, customer_id, name, description, price, city, hero_image) values ('3', '2', 'Different Users House', '#{description}', 400, 'london', '#{sample_image}');")
end

def add_row_to_test_customer_table
  @connection = connect
  @connection.exec("INSERT INTO customer (id, email, password) values ('1', 'Linked Test Customer', 'linked@example.com');")
end

def add_row_to_test_booking_table
  @connection = connect
  @connection.exec("INSERT INTO booking (id, customer_id, space_id, request) values ('1', '1', '1', 'pending');")
end

def add_second_row_to_test_booking_table
  @connection = connect
  @connection.exec("INSERT INTO booking (id, customer_id, space_id, request) values ('2', '1', '2', 'pending');")
end

def add_third_row_to_test_booking_table
  @connection = connect
  @connection.exec("INSERT INTO booking (id, customer_id, space_id, request) values ('3', '1', '3', 'pending');")
end

def add_linked_records_to_all_tables
  add_row_to_test_customer_table
  add_row_to_test_space_table
  add_row_to_test_booking_table
end

def add_additional_spaces_and_bookings
  add_second_row_to_test_space_table
  add_third_row_to_test_space_table
  add_second_row_to_test_booking_table
  add_third_row_to_test_booking_table
end
