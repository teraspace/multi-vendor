class Spree::LocationManagerAbility
  include CanCan::Ability

  def initialize(user)
    @vendor_ids = user.vendors.active.ids

    if @vendor_ids.any?
      if user.stock_locations.any?
        cannot :manage, Spree::Order
        can [:admin, :index, :edit, :update, :cart], Spree::Order, shipments: { stock_location: { id: user.stock_location_ids } }
        cannot :manage, Spree::Product
        cannot :manage, Spree::StockLocation
        cannot :manage, Spree::ShippingMethod
        cannot :manage, Spree::AuthenticationMethod
        cannot :manage, Spree::Vendor
      else
        can :manage, Spree::User, vendors: { id: @vendor_ids }
        cannot :destroy, Spree::User
      end
    end
  end
end