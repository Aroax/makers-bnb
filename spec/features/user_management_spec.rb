require 'user'

feature "user management" do

 let(:email) {"bla@example.com"}
 let(:password) {"qwerty"}

  scenario "a user registers" do
    visit "/spaces"
    click_link "Register"
    expect(current_path).to eq "/users/register"
    fill_in "email", with: "#{email}"
    fill_in "password", with: password
    click_button "Register"
    expect(current_path).to eq "/spaces"
    expect(page).to have_content "#{email}"
  end

  scenario "a user logs in" do
    register_user(email: email, password: password)

    visit "/spaces"
    click_link "Logout"

    visit "/spaces"
    click_link "Login"
    expect(current_path).to eq "/users/login"
    fill_in "email", with: "#{email}"
    fill_in "password", with: password
    click_button "Login"
    expect(current_path).to eq "/spaces"
    expect(page).to have_content "#{email}"
  end

  scenario "a user logs out" do
    register_user(email: email, password: password)

    visit "/spaces"
    click_link "Logout"
    expect(page).to have_link "Login"
    expect(page).to have_link "Register"
  end

end
