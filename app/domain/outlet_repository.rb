class OutletRepository
  MINIMUM_DELIVERY_DATE = 4.weeks.ago

  class << self


    def get_outlets(postcode = nil)
      outlets = Outlet.joins(:stock_items).where('stock_items.delivery_date > ?', MINIMUM_DELIVERY_DATE).uniq
      return sort_by_name(outlets.to_a) unless postcode.present?

      location = CoordinatesQuery.for_postcode(postcode)
      add_distances_and_sort(outlets.to_a, location)
    end

    private

    def sort_by_name(outlets)
      outlets.sort! { |x, y| no_definite_article(x.name) <=> no_definite_article(y.name) }
    end

    def no_definite_article(text)
      text.sub /^The /, ''
    end

    def add_distances_and_sort(outlets, location)
      outlets.map do |outlet|
        outlet_location = [ outlet.lat, outlet.long ]
        outlet.attributes.merge(
          {
            distance: Utils.distance_in_miles(outlet_location, location).round(2),
            distance_units: ' miles away'
          }
        )
      end.sort { |x, y| x[:distance] <=> y[:distance] }
    end
  end
end
