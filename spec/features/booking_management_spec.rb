feature 'bookings can be managed by hosts' do
let(:email) { "test@example.com" }
let(:password) { "qwerty" }

  scenario 'a Host can approve a booking' do
    register_and_login_user(email: email, password: password)
    add_space("Cherry Tree")
    request_space

    expect(current_path).to eq '/users/dashboard'
    expect(page).to have_content("Cherry Tree")

    click_button("approve")
    expect(page).to have_content "Booking Request Approved!"

  end
end
