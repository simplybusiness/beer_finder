require 'rails_helper'

RSpec.describe Outlet do


  context "creating new outlet" do

    let(:name) { 'Red Lion' }
    let(:address) { ['99 Gresham Street', 'London'] }
    let(:type) { 'pub' }
    let(:postcode) { 'EC2V 7NG' }

    it 'can be instantiated' do
      outlet = Outlet.new(name, address, postcode, type)

      expect(outlet.name).to eq(name)
      expect(outlet.address).to eq(address)
      expect(outlet.type).to eq(type)
      expect(outlet.postcode).to eq(postcode)
      expect(outlet.stock).to eq([])
    end

  end

  context "managing the stock" do
    let(:example_outlet) { Outlet.new('Red Lion', ['99 Gresham Street', 'London'], 'pub', 'EC2V 7NG') }
    let(:example_stock) { Stock.new("Foo", "bar", "can", Date.parse("2018-09-02")) }

    it 'can have stock' do
      example_outlet.add_stock_item(example_stock)

      expect(example_outlet.stock.count).to eq(1)
    end
  end

end
