RSpec.describe JSON::Mapping do
  it "has a version number" do
    expect(JSON::Mapping::VERSION).not_to be nil
  end

  class Location
    JSON.mapping(
      self,
      lat: Float,
      lng: Float,
    )
  end

  class House
    JSON.mapping(
      self,
      address: String,
      location: Location,
    )
  end

  let :location_json do
    '{"lat":12.3,"lng":34.5}'
  end

  let :house_json do
    "{\"address\":\"Crystal Road 1234\", \"location\":#{location_json}}"
  end

  it 'defines attributes' do
    house = House.new
    expect(house).to respond_to :address
    expect(house).to respond_to :location

    location = Location.new
    expect(location).to respond_to :lat
    expect(location).to respond_to :lng
  end

  def expect_location(location)
    expect(location).to be_a Location
    expect(location.lat).to eq 12.3
    expect(location.lng).to eq 34.5
  end

  it 'can maps json data to a ruby object' do
    location = Location.from_json(location_json)
    expect_location(location)
  end

  it 'maps nested json objects' do
    house = House.from_json(house_json)
    expect(house.address).to eq 'Crystal Road 1234'
    expect_location(house.location)
  end
end
