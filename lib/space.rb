require 'pg'
require_relative "database_connection"

class Space

  attr_reader :name, :description, :city, :price, :hero_image

  def initialize(name:, description:, city:, price:, hero_image:)
    @name = name
    @description = description
    @city = city
    @hero_image = hero_image
    @price = price
  end

  def self.all
    spaces = DatabaseConnection.query(sql: "SELECT * FROM space;", params: [])
    spaces.map do |space|
      Space.new(name: space['name'], description: space['description'], price: space['price'], city: space['city'], hero_image: space['hero_image'])
    end
  end

end
