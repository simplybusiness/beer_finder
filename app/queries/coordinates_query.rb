class CoordinatesQuery
  def self.for_postcode(postcode)
    results = Geocoder.search(postcode)
    return results.first.coordinates if results.present?
    []
  end
end
