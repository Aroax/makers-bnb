require 'pg'

# class DatabaseConnection
#
#   def self.setup(dbname)
#     # ENV['ENVIRONMENT'] = "test"
#     if ENV['ENVIRONMENT'] == "test"
#       @connection = PG.connect(dbname: 'makers_bnb_test')
#     else
#       @connection = PG.connect(dbname: 'makers_bnb')
#     end
#   end
#
#   def self.query(sql: ,params: )
#     @connection.exec_params(sql, params)
#   end
# end

class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.connection
    @connection
  end

  def self.query(sql: ,params: )
    @connection.exec_params(sql, params)
  end
end
