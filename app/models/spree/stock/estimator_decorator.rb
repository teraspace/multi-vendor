module Spree::Stock::EstimatorDecorator
  def shipping_methods(package, display_filter)
    package.shipping_methods.select do |ship_method|
      calculator = ship_method.calculator

      ship_method.available_to_display?(display_filter) &&
        (ship_method.pickup == @order.pickup) &&
        ship_method.include?(order.ship_address) &&
        calculator.available?(package) &&
        (calculator.preferences[:currency].blank? ||
         calculator.preferences[:currency] == currency)
    end
  end
end

Spree::Stock::Estimator.prepend(Spree::Stock::EstimatorDecorator)