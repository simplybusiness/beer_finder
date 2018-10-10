class Outlet < ApplicationRecord

  attr_accessor :distance
  attr_accessor :distance_units
  has_many :stock_items
end
