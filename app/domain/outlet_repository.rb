class OutletRepository
  MINIMUM_DELIVERY_DATE = 4.weeks.ago

  class << self


    def get_outlets(postcode = nil)
      outlets = Outlet.joins(:stock_items).where('stock_items.delivery_date > ?', MINIMUM_DELIVERY_DATE).uniq
      sort_by_name(outlets.to_a) unless postcode.present?

      outlets = add_items(outlets.to_a)

      return outlets if postcode.nil?
      add_distances(outlets, postcode)
    end

    private

    def add_image_tags(items)
      items.map do |item|
        icon = item["serving_style"] == 'keg' ? 'tap.png' : 'beer-can.png'
        item.merge(
          { icon_image: ActionController::Base.helpers.image_url(icon) }
        )
      end
    end

    def sort_by_name(outlets)
      outlets.sort! { |x, y| no_definite_article(x.name) <=> no_definite_article(y.name) }
    end

    def no_definite_article(text)
      text.sub /^The /, ''
    end

    def add_items(outlets)
      outlets.map do |outlet|
        outlet_hash = outlet.attributes.merge(
          { stock_items: add_image_tags(outlet.stock_items.map(&:attributes)) }
        )
      end
    end

    def add_distances(outlets, postcode)
      user_location = CoordinatesQuery.for_postcode(postcode)
      outlets.map do |outlet|
        outlet_location = [ outlet['lat'], outlet['long'] ]
        outlet.merge(
          {
            distance: Utils.distance_in_miles(outlet_location, user_location).round(2),
            distance_units: ' miles away',
          }
        )
      end.sort { |x, y| x['distance'] <=> y['distance'] }
    end
  end
end
