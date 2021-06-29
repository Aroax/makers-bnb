require_relative '../../lib/space'
require_relative '../setup_test_database'

describe Space do
  describe '.all' do
    it 'displays all spaces' do
      add_row_to_test_space_table
      space = Space.all

      expect(space.length).to eq 1
      expect(space.first).to be_a Space
      expect(space.first.id).to eq space.id
      expect(space.first.name).to eq "Dream Test House"
      expect(space.first.description).to eq "lorem ipsum"
      expect(space.first.price).to eq 400
      expect(space.first.city).to eq "london"
      expect(space.first.hero_image).to eq "./public/images/placeholder.jpg"
    end
  end
end
