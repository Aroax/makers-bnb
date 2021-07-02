require_relative "database_connection"

class Space
  attr_reader :customer_id, :id, :name, :description, :city, :price, :hero_image

  def self.add(customer_id:, name:, description:, city:, price:, hero_image:)
    result = DatabaseConnection.query(sql: "INSERT INTO space (customer_id, name, description, city, price, hero_image) VALUES ($1, $2, $3, $4, $5, $6) RETURNING customer_id, id, name, description, city, price, hero_image;", params: [customer_id, name, description, city, price, hero_image])
    space = Space.new(
      customer_id: result[0]["customer_id"],
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
    space = Space.new(
      customer_id: result[0]["customer_id"],
      id: result[0]["id"],
      name: result[0]["name"],
      description: result[0]["description"],
      city: result[0]["city"],
      price: result[0]["price"],
      hero_image: result[0]["hero_image"],
    )
    return space
  end

  def self.find_by_customer_id(customer_id:)
    result = DatabaseConnection.query(sql: "SELECT * FROM space WHERE customer_id = $1;", params: [customer_id])
    owned_spaces = result.map { |space|
      Space.new(
        id: space["id"],
        name: space["name"],
        description: space["description"],
        city: space["city"],
        price: space["price"],
        hero_image: space["hero_image"],
      )
    }
    return owned_spaces
  end

  def self.show_all
    spaces = DatabaseConnection.query(sql: "SELECT * FROM space;", params: [])
    spaces.map do |space|
      Space.new(customer_id: space["customer_id"], id: space["id"], name: space["name"], description: space["description"], price: space["price"], city: space["city"], hero_image: space["hero_image"])
    end
  end

  def self.find_by_customer_id(customer_id:)
    result = DatabaseConnection.query(sql: "SELECT * FROM space WHERE customer_id = $1;", params: [customer_id])
    result.map do |space|
      Space.new(customer_id: space["customer_id"], id: space["id"], name: space["name"], description: space["description"], price: space["price"], city: space["city"], hero_image: space["hero_image"])
    end
  end

  def initialize(customer_id:, id:, name:, description:, city:, price:, hero_image:)
    @customer_id = customer_id
    @id = id
    @name = name
    @description = description
    @city = city
    @price = price
    @hero_image = hero_image
  end
end
