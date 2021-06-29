# Setup with heavy referencing of the Bookmark Manager 'Extracting a Database Setup Object' Chapter 14
# (and some educated guesswork after having absorbed Eddie's new chapter 12 on security considerations)

require 'pg'
require './lib/database_connection'

describe DatabaseConnection do

  describe '.setup' do

    it 'connects to the test database' do
      expect(PG).to receive(:connect).with(dbname: 'makers_bnb_test')
      DatabaseConnection.setup('makers_bnb_test')
    end

  end

  describe '.query' do

    it 'executes an injection-protected query via PG' do
      connection = DatabaseConnection.setup('makers_bnb_test')
      expect(connection).to receive(:exec_params).with("SELECT * FROM spaces;", [])
      DatabaseConnection.query(sql: "SELECT * FROM spaces;", params: [])
    end

  end

end
