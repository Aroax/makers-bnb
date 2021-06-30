feature 'adding a space' do

  scenario 'hosts can add a space' do
    visit '/spaces'
    click_button('List a Space')

    expect(current_path).to eq '/spaces/new'

    fill_in(:name, with: "test space")
    fill_in(:description, with: "lorem ipsum")
    fill_in(:city, with: "London")
    fill_in(:price, with: 350)

    click_button('submit')

    expect(current_path).to eq '/spaces'
    expect(page).to have_content("test space")
  end
end
