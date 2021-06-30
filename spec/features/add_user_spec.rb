

feature "user registration" do
  
 let(:email) {"bla@example.com"}

  scenario "a user registers" do
    visit "/spaces"
    click_link "Register"
    expect(current_path).to eq "/users/register"
    fill_in "email", with: "#{email}"
    fill_in "password", with: "qwerty"
    click_button "Register" 
    expect(current_path).to eq "/spaces"
    expect(page).to have_content "#{email}"
  end

end