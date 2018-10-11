require "rails_helper"

RSpec.describe OutletRepository do
  it "returns outlet with de-duped stock items" do
    outlet = Outlet.create(name: "Outlet 1")
    example_stock_item_1_1 = StockItem.create({ name: "Example Stock 1",
                                                outlet: outlet,
                                                delivery_date: Date.parse("2018-09-04") })
    example_stock_item_1_2 = StockItem.create({ name: "Example Stock 1",
                                                outlet: outlet,
                                                delivery_date: Date.parse("2018-09-01") })
    example_stock_item_2   = StockItem.create({ name: "Example Stock 2",
                                                outlet: outlet,
                                                delivery_date: Date.parse("2018-09-03") })

    outlets = OutletRepository.get_outlets

    expect(outlets.length).to eq(1)
    outlet = outlets.first
    expect(outlet.recent_stock_items.length).to eq(2)
    expect(outlet.recent_stock_items).to include(example_stock_item_1_1)
    expect(outlet.recent_stock_items).to include(example_stock_item_2)
    expect(outlet.recent_stock_items).not_to include(example_stock_item_1_2)
  end
end
