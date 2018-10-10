class FinderController < ApplicationController
  def index
      # THIS CAN BE REMOVED and replaced with OutletRepository.get_outley
      @outlets = []
      stock1 = build_stock(name: 'Gecko', style: 'Little Beer', serving_style: 'can', delivery_date: Date.parse("2018-02-03"))
      stock2 = build_stock(name: 'Gecko', style: 'Little Beer', serving_style: 'can', delivery_date: Date.parse("2018-02-03"))
      stock3 = build_stock(name: 'Gecko', style: 'Little Beer', serving_style: 'can', delivery_date: Date.parse("2018-02-03"))
      @outlets << build_outlet(name: 'Red Lion', address: ['99 Gresham Street', 'London'], postcode: 'EC2V 7NG', type: 'pub', stocks: [stock1, stock2])
      @outlets << build_outlet(name: 'Job Centre', address: ['11 Gresham Street', 'London'], postcode: 'ECV 8SN', type: 'pub', stocks: [stock2, stock3])

      sort_by_name

  end

  # THIS CAN BE REMOVED ONCE WE GET THE REAL DATA
  def build_stock(name:, style:, serving_style:, delivery_date:)
    Stock.new(name, style, serving_style, delivery_date)
  end

  def build_outlet(name:, address:, postcode:, type:, stocks:)
    outlet = Outlet.new(name, address, postcode, type)
    stocks.each { |stock| outlet.add_stock_item(stock) }
    outlet
  end

  def sort_by_name
    @outlets.sort! { |x, y| x.name <=> y.name }
  end
end
