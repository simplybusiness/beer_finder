class Outlet < ApplicationRecord

  attr_accessor :distance
  has_many :stock_items
end
