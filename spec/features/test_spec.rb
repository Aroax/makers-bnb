feature "Testing page" do
  scenario "visiting the index page" do
    visit("/test")
    expect(page.status_code).to eq 200
  end
end
