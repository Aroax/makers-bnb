require_relative "database_connection"

class Space
  attr_reader :id, :name, :description, :city, :price, :hero_image

  def self.add(name:, description:, city:, price:, hero_image:)
    result = DatabaseConnection.query(sql: "INSERT INTO space (name, description, city, price, hero_image) VALUES ($1, $2, $3, $4, $5) RETURNING id, name, description, city, price, hero_image;", params: [name, description, city, price, hero_image])
    space = Space.new(
      id: result[0]["id"],
      name: result[0]["name"],
      description: result[0]["description"],
      city: result[0]["city"],
      price: result[0]["price"],
      hero_image: result[0]["hero_image"],
    )
  end

  def self.find_by_id(space_id:)
    result = DatabaseConnection.query(sql: "SELECT * FROM space WHERE id = $1;", params: [space_id])

    Space.new(
      id: result[0]["id"],
      name: result[0]["name"],
      description: result[0]["description"],
      city: result[0]["city"],
      price: result[0]["price"],
      hero_image: result[0]["hero_image"],
    )
  end

  def initialize(id:, name:, description:, city:, price:, hero_image:)
    @id = id
    @name = name
    @description = description
    @city = city
    @price = price
    @hero_image = hero_image
  end
end
