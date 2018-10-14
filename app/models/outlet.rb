class Outlet < ApplicationRecord

  has_many :stock_items

  def recent_stock_items
    stock_items.order(delivery_date: :desc)
      .group_by(&:name)
      .map { |(_k, v)| v.first }
  end

end
