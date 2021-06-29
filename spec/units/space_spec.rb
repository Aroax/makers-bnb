require_relative '../../lib/space'
require_relative '../setup_test_database'

describe Space do
  
  let(:name) { double(:name) }
  let(:description) { double(:description) }
  let(:price) { 350 }
  let(:city) { double(:city) }
  let(:hero_image) { double(:hero_image) }
  
  describe '.all' do
    it 'displays all spaces' do
      add_row_to_test_space_table
      space = Space.all
      
      expect(space.length).to eq 1
      expect(space.first).to be_a Space
      # expect(space.first.id).to eq space.id
      expect(space.first.name).to eq "Dream Test House"
      expect(space.first.description).to eq "lorem ipsum"
      expect(space.first.price).to eq "400"
      expect(space.first.city).to eq "london"
      expect(space.first.hero_image).to eq "./public/images/placeholder.jpg"
    end
  end
  

  
  describe '.add' do
    it 'adds a new space to the database' do
      space = Space.add(name: name, description: description, city: city, price: price, hero_image: hero_image)

      expect(space.name).to eq "#{name}"
      expect(space.description).to eq "#{description}"
      expect(space.city).to eq "#{city}"
      expect(space.price).to eq "#{price}"
    end
  end
end
