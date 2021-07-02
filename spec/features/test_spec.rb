feature "Testing page" do
  scenario "visiting the index page" do
    visit("/test")
    expect(page.status_code).to eq 200

    register_and_login_user(email: "new_test@example.com", password: "test")
    request_space
  end
end
