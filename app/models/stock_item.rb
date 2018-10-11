class StockItem < ApplicationRecord
  belongs_to :outlet

  def icon
    serving_style == 'keg' ? 'tap.png' : 'beer-can.png'
  end
end
