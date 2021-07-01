feature "Unavailability Alert" do
  scenario "shows customer alert if dates unvailable" do
    register_user(email: "hello@example.com", password: "qwerty")
    add_space
    request_space
    request_space

    expect(page).to have_content "Sorry, this property is unavailable on 2021-09-03 :("
  end
end
