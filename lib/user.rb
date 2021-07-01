class User
attr_reader :id, :email

  def self.add(email:, password:)
    result = DatabaseConnection.query(sql: "INSERT INTO customer (email, password) VALUES ($1, $2) RETURNING id, email;", params: [email, password])
    user = User.new(
      id: result[0]['id'],
      email: result[0]['email']
    )
  end

  def self.find_user_by_email(email: )
    result = DatabaseConnection.query(sql: "SELECT * FROM customer WHERE email = $1 ;", params: [email])
    result.map do |user|
      User.new(
        id: result[0]['id'],
        email: result[0]['email']
      )
    end
  end

  def self.authenticate(email:, password:)
    result = DatabaseConnection.query(sql: "SELECT * FROM customer WHERE email = $1;", params: [email])
    return unless result.any?
    return unless password == result[0]['password']
    user = User.new(
      id: result[0]['id'],
      email: result[0]['email']
    )
  end

  def self.validate?(email:)
  result = DatabaseConnection.query(sql: "SELECT * FROM customer WHERE email = $1;", params: [email])
  return true if result.any?
end

  def initialize(id: , email: )
    @id = id
    @email = email
  end
end
