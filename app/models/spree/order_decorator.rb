module Spree::OrderDecorator
  def self.prepended(base)
    base.attr_accessor :stock_location_id
    base.before_save :copy_stock_location_address
  end

  def copy_stock_location_address
    if stock_location_id && pickup?
      location = Spree::StockLocation.find(stock_location_id)
      ship_address.address1 = location.address1
      ship_address.address2 = location.address2
      ship_address.city = location.city
      ship_address.state = location.state
      ship_address.country = location.country
      ship_address.save!
    end
  end
end

Spree::Order.prepend(Spree::OrderDecorator)