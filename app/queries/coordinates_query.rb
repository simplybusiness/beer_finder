class CoordinatesQuery
  def self.for_postcode(postcode)
    results = Geocoder.search(postcode)
    return results.first.coordinates if results.present?
    # return villages coord if not found
    [51.478605, -0.02474]
  end
end
