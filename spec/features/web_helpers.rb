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
  add_space

  # all("#space").first.click_link "View"
  first("#space").click_link "View"
  fill_in(:date_in, with: "2021-09-03")
  fill_in(:date_out, with: "2021-09-04")
  click_button "Request to Book"
end
