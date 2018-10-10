class Utils

  class << self

    def get_beer_name(text)
      text = text.sub /\ can.*/, ''
      text.sub /\ keg.*/, ''
    end

    def is_keg?(text)
      text.include? 'keg'
    end

    def serving_style(text)
      is_keg?(text) ? 'keg' : 'can'
    end

    def distance_in_km(loc1, loc2)
      rad_per_deg = Math::PI / 180 # PI / 180
      rkm = 6371 # Earth radius in kilometers

      dlat_rad = (loc2[0] - loc1[0]) * rad_per_deg # Delta, converted to rad
      dlon_rad = (loc2[1] - loc1[1]) * rad_per_deg

      lat1_rad, lon1_rad = loc1.map { |i| i * rad_per_deg }
      lat2_rad, lon2_rad = loc2.map { |i| i * rad_per_deg }

      a = Math.sin(dlat_rad / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad / 2) ** 2
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))

      rkm * c # Delta in meters

    end

    def distance_in_miles(loc1, loc2)
      distance_in_km(loc1, loc2) * 0.621371
    end

  end
end
