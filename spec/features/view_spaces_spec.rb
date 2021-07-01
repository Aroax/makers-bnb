require "pg"

feature "View spaces" do
  scenario "user can view spaces" do
    register_and_login_user(email: "email@example.com", password: "password")
    add_space
    visit "/spaces"
    expect(page).to have_content "Dream House"
  end
end
