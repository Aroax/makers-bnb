require_relative 'database_connection'

class Space
  attr_reader :name, :description, :city, :price, :hero_image

  def self.add(name:,description:,city:,price:,hero_image:)
    result = DatabaseConnection.query(sql:"INSERT INTO space (name, description, city, price, hero_image) VALUES ($1, $2, $3, $4, $5) RETURNING name, description, city, price, hero_image;", params: [name, description, city, price, hero_image])
    # p result
    space = Space.new(
      name: result[0]['name'],
      description: result[0]['description'],
      city: result[0]['city'],
      price: result[0]['price'],
      hero_image: result[0]['hero_image']
    )
    # p space
  end

  def initialize(name:, description:, city:, price:, hero_image:)
    @name = name
    @description = description
    @city = city
    @price = price
    @hero_image = hero_image
  end

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

  def self.add(name:,description:,city:,price:,hero_image:)
    result = DatabaseConnection.query(sql:"INSERT INTO space (name, description, city, price, hero_image) VALUES ($1, $2, $3, $4, $5) RETURNING name, description, city, price, hero_image;", params: [name, description, city, price, hero_image])
    space = Space.new(
      name: result[0]['name'],
      description: result[0]['description'],
      city: result[0]['city'],
      price: result[0]['price'],
      hero_image: result[0]['hero_image']
    )
  end

end
