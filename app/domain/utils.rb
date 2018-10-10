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

  end
end
