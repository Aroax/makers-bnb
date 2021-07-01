def add_space
  visit "/spaces"
  click_button("List a Space")

  fill_in(:name, with: "Dream House")
  fill_in(:description, with: "lorem ipsum")
  fill_in(:city, with: "london")
  fill_in(:price, with: 350)

  click_button("submit")
end

def request_space

  # all("#space").first.click_link "View"
  first(".space").click_link "View"
  fill_in(:date_in, with: "2021-09-03")
  fill_in(:date_out, with: "2021-09-04")
  click_button "Request to Book"
end

def register_user(email:, password:)
  visit "/spaces"
  click_link "Register"
  fill_in "email", with: email
  fill_in "password", with: password
  click_button "Register"
end

def register_and_login_user(email:, password:)
  register_user(email: email, password: password)
  logout_user
  visit "/spaces"
  click_link "Login"
  fill_in "email", with: email
  fill_in "password", with: password
  click_button "Login"
end

def logout_user
  visit "/spaces"
  click_link "Logout"
end
