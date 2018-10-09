require 'rails_helper'

RSpec.describe OutletsController, type: :controller do
  describe 'Index' do
    it 'renders a JSON representation of the outlets' do
      stock = build_stock(name: 'Gecko', style: 'Little Beer', serving_style: 'can', delivery_date: Date.parse("2018-02-03"))
      outlet = build_outlet(name: 'Red Lion', address: ['99 Gresham Street', 'London'], postcode: 'EC2V 7NG', type: 'pub', stocks: [stock])
      allow(OutletRepository).to receive(:get_outlets).and_return([outlet])

      get :index

      parsed = JSON.parse(response.body)

      expect(parsed).to eq({
        "outlets" => [
          {
            "name" => "Red Lion",
            "address" => ["99 Gresham Street", "London"],
            "postcode" => "EC2V 7NG",
            "type" => "pub",
            "stock" => [
              {
                "name" => "Gecko",
                "style" => "Little Beer",
                "serving_style" => "can",
                "delivery_date" => "2018-02-03"
              }
            ]
          }
        ]
      })
    end

    def build_stock(name:, style:, serving_style:, delivery_date:)
      Stock.new(name, style, serving_style, delivery_date)
    end

    def build_outlet(name:, address:, postcode:, type:, stocks:)
      outlet = Outlet.new(name, address, postcode, type)
      stocks.each { |stock| outlet.add_stock_item(stock) }
      outlet
    end
  end
end
