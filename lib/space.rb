require 'pg'
require_relative "database_connection"

class Space

  def initialize(name:, description:, city:, price:, hero_image: )
    @id = id
    @name = name
    @description = description
    @city = city
    @hero_image = hero_image
  end

  def self.all
    spaces = DatabaseConnection.query(sql: "SELECT * FROM space;", params: [])
    result = spaces.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], price: space['price'], city: space['city'], hero_image: space['hero_image'])
    end
  end

end
