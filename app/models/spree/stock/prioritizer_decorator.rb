module Spree::Stock::PrioritizerDecorator
  # Set ship_address with user location and pick nearest stock location
  def sort_packages
    order = packages.map(&:order).uniq.first
    ship_address = order.ship_address
    stock_locations = Spree::StockLocation.where(id: packages.map(&:stock_location).map(&:id))
    vendors = stock_locations.map(&:vendor).uniq

    # Get the closest stock location within the delivery distance ratio
    if vendors.any? && vendors.size == 1
      near_stock_location = stock_locations.near(ship_address.full_address, vendors.first.delivery_distance).first
      @packages = @packages.select {|p| p.stock_location == near_stock_location }
    else
      # TODO: Investigate if this can be possible. Multi vendor with multi stock locations
    end
  end
end

Spree::Stock::Prioritizer.prepend(Spree::Stock::PrioritizerDecorator)