require "database_connection"

describe User do

  let(:email) {"bla@example.com"}
  let(:password) {"qwerty"}

  describe ".add" do
    it "adds user registration info to the DB" do
      register = User.add(email: "#{email}", password: "#{password}")
      confirmed = User.find_user_by_email(email: email)

      expect(register.id).to eq confirmed.first.id
    end
  end

  describe ".authenticate" do

    it 'validates registered user login attempt agains DB' do
      register = User.add(email: email, password: password)
      user = User.authenticate(email: email, password: password)

      expect(user.id).to eq register.id

    end

    it 'validates unregistered user login attempt agains DB' do
      user = User.authenticate(email: email, password: password)

      expect(user).to be nil
    end

  end

end
