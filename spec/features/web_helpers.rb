
def add_space
  visit '/spaces'
      click_link('add a space')

      fill_in(:name, with: "Dream House")
      fill_in(:description, with: "lorem ipsum")
      fill_in(:city, with: "london")
      fill_in(:price, with: 350)

      click_button('submit')
end
