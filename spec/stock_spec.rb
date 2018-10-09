require 'rails_helper'

RSpec.describe Stock do

  let(:name) { 'Gecko' }
  let(:style) { 'Little Beer' }
  let(:serving_style) { 'can' }
  let(:delivery_date) { Date.parse("2018-02-03") }


  it 'can be instantiated' do
    outlet = Stock.new(name, style, serving_style, delivery_date)

    expect(outlet.name).to eq(name)
    expect(outlet.style).to eq(style)
    expect(outlet.serving_style).to eq(serving_style)
    expect(outlet.delivery_date).to eq(delivery_date)
  end

end
