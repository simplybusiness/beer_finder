class Stock
  attr_reader :name, :style, :serving_style, :delivery_date

  def initialize(name, style, serving_style, delivery_date)
    @name = name
    @style = style
    @serving_style = serving_style
    @delivery_date = delivery_date
  end

end
