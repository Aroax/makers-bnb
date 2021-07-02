require 'database_connection'

feature "booking spaces" do
  scenario "a user can request to book a space" do

    # space = DatabaseConnection.query(sql: "INSERT INTO space (name, description, city) VALUES ($1, $2, $3) RETURNING id;", params: ["New Test House", "lorem ipsum", "Chicago"])
    # space_id = space[0]
    register_and_login_user(email:"test@example.com", password: "qwerty")
    add_space("Apple Orchard")
    page.first('#spaceCard').click_link("View")
    expect(page).to have_content("Apple Orchard")
    request_space

    expect(current_path).to eq('/users/dashboard')
    expect(page).to have_content("Apple Orchard")
  end
end
