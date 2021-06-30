require "database_connection"

describe User do

  let(:email) {"bla@example.com"}
  let(:password) {"qwerty"}

  describe ".add" do
    it "adds user registration info to the DB" do
      register = User.add(email: "#{email}", password: "#{password}")
      confirmed = User.find_user_by_email(email:"#{email}")

      expect(register.id).to eq confirmed.first.id
    end
  end

end