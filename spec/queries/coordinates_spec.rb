require 'rails_helper'

RSpec.describe CoordinatesQuery do
  subject(:get_coordinates) { described_class }

  it 'returns the lat & long given a postcode' do
    coordinates = get_coordinates.for_postcode('EC2V 7NG')
    expect(coordinates).to eq [51.515321763772, -0.090416409760255]
  end

  it 'returns villages coords if postcode not found' do
    villages_cords = [51.478605, -0.02474]
    expect(get_coordinates.for_postcode('SW1Y 4AH')).to eq(villages_cords)
  end
end
