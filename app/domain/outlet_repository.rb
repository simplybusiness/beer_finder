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
      clean_up_all(outlets)
      outlets.sort! { |x, y| no_definite_article(x.name) <=> no_definite_article(y.name) }
    end

    def no_definite_article(text)
      text.sub /^The /, ''
    end

    def sort_by_distance(outlets, location)
      clean_up_all(outlets)
      add_distances(outlets, location)
      outlets.sort! { |x, y| x.distance <=> y.distance }
    end

    def add_distances(outlets, location)
      outlets.each { |o| add_distance(o, location) }
    end

    def add_distance(outlet, location)
      outlet_location = [ outlet.lat, outlet.long ]
      outlet.distance = Utils.distance_in_miles(outlet_location, location).round
      outlet.distance_units = ' miles away'
    end


    def clean_up_all(outlets)
      outlets.each { |o| clean_up_stock(o) }
    end

    def clean_up_stock(outlet)
      outlet.stock_items.each { |o| clean_up(o) }
    end

    def clean_up(stock_item)
      # stock_item.name = Utils.get_beer_name(name)
      # stock_item.serving_style = Utils.serving_style(name)
      stock_item.icon = stock_item.serving_style == 'keg' ? 'tap.png' : 'beer-can.png'
    end


  end
end
