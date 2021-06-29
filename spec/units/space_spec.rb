require_relative "../../lib/space"

describe Space do
  let(:name) { double(:name) }
  let(:description) { double(:description) }
  let(:price) { 350 }
  let(:city) { double(:city) }
  let(:hero_image) { double(:hero_image) }

  it "is an infinite void" do
  end

  describe ".add" do
    it "adds a new space to the database" do
      space = Space.add(name: name, description: description, city: city, price: price, hero_image: hero_image)

      expect(space.name).to eq "#{name}"
      expect(space.description).to eq "#{description}"
      expect(space.city).to eq "#{city}"
      expect(space.price).to eq "#{price}"
    end
  end

  describe ".find_by_id" do
    it "returns the space object" do
      space = Space.add(name: name, description: description, city: city, price: price, hero_image: hero_image)

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
