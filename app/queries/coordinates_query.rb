class CoordinatesQuery
  def self.for_postcode(postcode)
    results = Geocoder.search(postcode)
    results.first.coordinates
  end
end
