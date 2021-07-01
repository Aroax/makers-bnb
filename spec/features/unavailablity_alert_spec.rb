feature "Unavailability Alert", :focus do
  scenario "shows customer alert if dates unvailable" do
    request_space
    request_space

    expect(page).to have_content "Sorry, this property is unavailable on 2021-09-03 :("
  end
end
