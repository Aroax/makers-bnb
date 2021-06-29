require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makers_bnb_test')
  # connection.exec("TRUNCATE booking, customer, message, space;")
end

def add_row_to_test_space_table
  description = "lorem ipsum"
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec("INSERT INTO space (customer_id, name, description, price, city) values ('1', 'Dream Test House', '#{description}'), '400', 'london';")
end
