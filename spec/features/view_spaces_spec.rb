require 'pg'

feature 'View spaces' do
  scenario 'user can view spaces' do
    add_row_to_test_space_table
    visit '/space'
    expect(page).to have_content "Dream Test House"
  end
end
