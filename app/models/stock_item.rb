class StockItem < ApplicationRecord
  attr_accessor :icon
  belongs_to :outlet
end
