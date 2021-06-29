require 'pg'

class DatabaseConnection

  def self.setup(dbname)
    if ENV['ENVIRONMENT'] == "test"
      @connection = PG.connect(dbname: 'makers_bnb_test')
    else
      @connection = PG.connect(dbname: 'makers_bnb')
    end
  end

  def self.query(sql: , params: )
    @connection.exec_params(sql, params)
  end
end
