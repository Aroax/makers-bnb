require_relative '../../lib/space'
require_relative '../setup_test_database'

describe Space do

  let(:customer_id) { double(:customer_id)}
  let(:name) { double(:name) }
  let(:description) { double(:description) }
  let(:price) { 350 }
  let(:city) { double(:city) }
  let(:hero_image) { double(:hero_image) }

  describe '.all' do
    it 'displays all spaces' do
      add_row_to_test_space_table
      space = Space.show_all

      expect(space.length).to eq 1
      expect(space.first).to be_a Space
      expect(space.first.name).to eq "Dream Test House"
      expect(space.first.description).to eq "lorem ipsum"
      expect(space.first.price).to eq "400"
      expect(space.first.city).to eq "london"
      expect(space.first.hero_image).to eq "./public/images/placeholder.jpg"
    end
  end



  describe '.add' do
    it 'adds a new space to the database' do
      space = Space.add(customer_id: customer_id, name: name, description: description, city: city, price: price, hero_image: hero_image)

      expect(space.name).to eq "#{name}"
      expect(space.description).to eq "#{description}"
      expect(space.city).to eq "#{city}"
      expect(space.price).to eq "#{price}"
    end
  end

  describe ".find_by_id" do
    it "returns the space object" do
      space = Space.add(customer_id: customer_id, name: name, description: description, city: city, price: price, hero_image: hero_image)

      result = Space.find_by_id(space_id: space.id)

      expect(result).to be_a Space
      expect(result.id).to eq space.id
      expect(result.name).to eq space.name
      expect(result.description).to eq space.description
      expect(result.city).to eq space.city
      expect(result.price).to eq space.price
    end
  end
end
