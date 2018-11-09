require "rails_helper"

RSpec.describe OutletRepository do
  subject(:get_outlets) { described_class.get_outlets }

  let!(:outlet_1) do
    Outlet.create(
      xero_contact_id: '100',
      name: 'foo',
      address: '1 Foo Road',
      postcode: 'E1 123',
      lat: 51.5074,
      long: 0.1278
    )
  end

  let!(:outlet_2) do
    Outlet.create(
      xero_contact_id: '200',
      name: 'The bar',
      address: '1 bar Road',
      postcode: 'E2 123',
      lat: 51.5050,
      long: 0.1280
    )
  end

  let(:example_stock_item_1) do
    StockItem.create(
      name: "Example Stock 1",
      delivery_date: Date.today,
      serving_style: 'keg'
    )
  end

  let(:example_stock_item_2) do
    StockItem.create(
      name: "Example Stock 2",
      delivery_date: Date.yesterday,
      serving_style: 'can'
    )
  end

  before do
    outlet_1.stock_items << [example_stock_item_1, example_stock_item_2]
  end

  it 'returns a collection containing the outlet with stock items as a hash' do
    outlet_hash = get_outlets.first
    expect(outlet_hash).to include(outlet_1.attributes)
    expect(outlet_hash[:stock_items].first).to include(example_stock_item_1.attributes)
    expect(outlet_hash[:stock_items].second).to include(example_stock_item_2.attributes)
  end

  it 'adds correct image paths to stock items depending on serving style' do
    keg_item = get_outlets.first[:stock_items].find { |i| i['serving_style'] == 'keg' }
    expect(keg_item[:icon_image]).to eq(ActionController::Base.helpers.image_url('tap.png'))
    can_item = get_outlets.first[:stock_items].find { |i| i['serving_style'] == 'can' }
    expect(can_item[:icon_image]).to eq(ActionController::Base.helpers.image_url('beer-can.png'))
  end

  it 'does not show items that have been delivered over 4 weeks ago' do
    outlet_1.stock_items.create(
      name: "Late Delivery",
      delivery_date: 4.weeks.ago,
      serving_style: 'keg'
    )
    expect(get_outlets.first[:stock_items].map {|i| i['name'] }).to_not include('Late Delivery')
  end

  it 'only returns outlets that have had stock items delivered' do
    expect(get_outlets.count).to eq(1)
    expect(get_outlets.first['xero_contact_id']).to eq(outlet_1.xero_contact_id)
  end

  it 'orders outlets by name ignoring the The' do
    outlet_2.stock_items.create(
      name: "Example Stock 2",
      delivery_date: Date.today,
      serving_style: 'keg'
    )
    expect(get_outlets.map { |o| o['name'] }).to eq(['The bar', 'foo'])
  end

end
