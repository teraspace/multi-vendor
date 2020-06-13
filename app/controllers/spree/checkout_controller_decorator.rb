module Spree::CheckoutControllerDecorator
  def before_delivery
    return if params[:order].present?

    packages = @order.shipments.map(&:to_package)
    @differentiator = Spree::Stock::Differentiator.new(@order, packages)
    
    if @order.shipments.size == 1 && @order.pickup?
      @order.next!
      redirect_to checkout_state_path(@order.state) and return
    end
  end
end

Spree::CheckoutController.prepend(Spree::CheckoutControllerDecorator)