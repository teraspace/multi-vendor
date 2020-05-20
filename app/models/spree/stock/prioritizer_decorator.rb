module Spree::Stock::PrioritizerDecorator
  # Set ship_address with user location and pick nearest stock location
  def sort_packages
    order = packages.map(&:order).uniq.first
    ship_address = order.ship_address
    stock_locations = Spree::StockLocation.where(id: packages.map(&:stock_location).map(&:id))
    near_stock_location = stock_locations.near(ship_address.full_address, 50).first
    @packages = @packages.select {|p| p.stock_location == near_stock_location }
  end
end

Spree::Stock::Prioritizer.prepend(Spree::Stock::PrioritizerDecorator)