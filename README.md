# JSON.mapping

A simple JSON mapper inspired by [Crystals](https://crystal-lang.org/api/JSON.html) `JSON.mapping`

## Usage

```ruby
require "json"

class Location
  JSON.mapping(
    lat: Float64,
    lng: Float64,
  )
end

class House
  JSON.mapping(
    address: String,
    location: {type: Location, nilable: true},
  )
end

house = House.from_json(%({"address": "Crystal Road 1234", "location": {"lat": 12.3, "lng": 34.5}}))
house.address  # => "Crystal Road 1234"
house.location # => #<Location:0x10cd93d80 @lat=12.3, @lng=34.5>
house.to_json  # => %({"address":"Crystal Road 1234","location":{"lat":12.3,"lng":34.5}})
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json-mapping.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
