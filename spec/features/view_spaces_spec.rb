require 'pg'

feature 'View spaces' do
  scenario 'user can view spaces' do
    # add_row_to_test_space_table
    add_space
    visit '/spaces'
    expect(page).to have_content "london"
  end
end
