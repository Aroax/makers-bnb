require_relative 'database_connection'

class Space
  attr_reader :name, :description, :city, :price, :hero_image

  def self.add(name:,description:,city:,price:,hero_image:)
    result = DatabaseConnection.query(sql:"INSERT INTO space (name, description, city, price, hero_image) VALUES ($1, $2, $3, $4, $5) RETURNING (name, description, city, price, hero_image);", params: [name, description, city, price, hero_image])
    p result
    # Space.new(
    #   name: result[0]['name'],
    #   description: result[0]['description'],
    #   city: result[0]['city'],
    #   price: result[0]['price'],
    #   hero_image: result[0]['hero_image']
    # )
  end

  def initialize(name:, description:, city:, price:, hero_image:)
    @name = name
    @description = description
    @city = city
    @price = price
    @hero_image = hero_image
  end

end
