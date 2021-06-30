feature "Unavailability Alert", :focus do
  scenario "shows customer alert if dates unvailable" do
    request_space
    request_space

    expect(page).to have_content "Sorry, this property is unavailable on this date :("
  end
end
