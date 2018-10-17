class Utils

  class << self

    def get_beer_name(text)
      t = text.clone
      t = t.sub /\ can.*/, ''
      t = t.sub /\ Can.*/, ''
      t = t.sub /\ keg.*/, ''
      t.sub /\ Keg.*/, ''
    end

    def is_keg?(text)
      return true if text.include? 'keg'
      return true if text.include? 'Keg'
      false
    end

    def serving_style(text)
      is_keg?(text) ? 'keg' : 'can'
    end
  end
end
