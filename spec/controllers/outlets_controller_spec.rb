require 'rails_helper'

RSpec.describe OutletsController, type: :controller do
  describe 'Index' do
    it 'renders a JSON representation of the outlets' do
      outlet = Outlet.new('Red Lion', ['99 Gresham Street', 'London'], 'EC2V 7NG', 'pub')
      stock_item = Stock.new('Gecko', 'Little Beer', 'can', Date.parse("2018-02-03"))
      outlet.add_stock_item(stock_item)
      outlet_list = [outlet]
      allow(OutletRepository).to receive(:get_outlets).and_return(outlet_list)

      get :index

      parsed = JSON.parse(response.body)

      expect(parsed).to eq(
        {
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
        }
      )
    end
  end
end
