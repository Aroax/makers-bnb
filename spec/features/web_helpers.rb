

def add_space(name="Dream House")
  @property_photos = [
    "https://loveincorporated.blob.core.windows.net/contentimages/gallery/c2446d25-e0f8-483a-bfcf-b53c2b0fbe27-31amazing-houses-for-sale-in-surprising-places-caribbean.jpg",
    "https://www.themostexpensivehomes.com/wp-content/uploads/2014/12/The-most-amazing-celebrity-homes8-670x290.jpg",
    "https://i1.wp.com/dl.img-news.com/dl/img/s4/dl/2020/05/6-amazing-houses-to-move-in-now.img.jpeg?w=696&ssl=1",
    "https://i2-prod.bristolpost.co.uk/incoming/article1321112.ece/ALTERNATES/s615/Tiverton-outside.jpg",
    "https://loveincorporated.blob.core.windows.net/contentimages/gallery/3fd2c2e3-418b-4f87-9262-2dfaba687497-east%20hamptons%20exterior.jpg",
    "https://summericeworld.files.wordpress.com/2015/06/wpid-psx_20150610_162648.jpg",
    "https://viralscape.com/wp-content/uploads/2014/03/unconventional-home-69.jpg",
    "https://img.huffingtonpost.com/asset/5afdfead1e00002c008e5dc8.jpeg?ops=scalefit_720_noupscale",
    "http://cdn.home-designing.com/wp-content/uploads/2010/03/house-with-lights.jpg",
    "https://cdn.luxatic.com/wp-content/uploads/2012/01/Spa-House-South-Africa-1.jpg"
  ]
  visit "/spaces"
  click_button("List a Space")

  fill_in(:name, with: name)
  fill_in(:description, with: "lorem ipsum")
  fill_in(:city, with: "london")
  fill_in(:price, with: 350)
  fill_in(:hero_image, with: @property_photos.sample)

  click_button("submit")
end

def request_space
  add_space
  page.first('#spaceCard').click_link("View")
  fill_in(:date_in, with: "2021-09-03")
  fill_in(:date_out, with: "2021-09-04")
  click_button "Request to Book"
end

def register_user(email:, password:)
  visit "/spaces"
  click_link "Register"
  fill_in "email", with: email
  fill_in "password", with: password
  click_button "Register"
end

def register_and_login_user(email:, password:)
  register_user(email: email, password: password)
  logout_user
  visit "/spaces"
  click_link "Login"
  fill_in "email", with: email
  fill_in "password", with: password
  click_button "Login"
end

def logout_user
  visit "/spaces"
  click_link "Logout"
end

# def request_space
#
#   # all("#space").first.click_link "View"
#   first(".space").click_link "View"
#   fill_in(:date_in, with: "2021-09-03")
#   fill_in(:date_out, with: "2021-09-04")
#   click_button "Request to Book"
# end
