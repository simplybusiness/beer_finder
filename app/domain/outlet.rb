class Outlet

  attr_reader :name, :address, :postcode, :type, :stock

  def initialize(name, address, postcode, type)
    @name = name
    @address = address
    @postcode = postcode
    @type = type
    @stock = []
  end

  def add_stock_item(stock_item)
    @stock << stock_item
  end
end
