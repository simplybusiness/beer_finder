class OutletRepository

  class << self


    def get_outlets(postcode = nil)
      outlets = Outlet.all
      return sort_by_name(outlets.to_a) unless postcode.present?

      location = CoordinatesQuery.for_postcode(postcode)
      sort_by_distance(outlets.to_a, location)
    end

    private

    def sort_by_name(outlets)
      outlets.sort! { |x, y| no_definite_article(x.name) <=> no_definite_article(y.name) }
    end

    def no_definite_article(text)
      text.sub /^The /, ''
    end

    def sort_by_distance(outlets, location)
      add_distances(outlets, location)
      outlets.sort! { |x, y| x.distance <=> y.distance }
    end

    def add_distances(outlets, location)
      outlets.each { |o| add_distance(o, location) }
    end

    def add_distance(outlet, location)
      outlet_location = [ outlet.lat, outlet.long ]
      outlet.distance = Utils.distance_in_miles(outlet_location, location).round
    end

  end
end
