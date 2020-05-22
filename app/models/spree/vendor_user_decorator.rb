module Spree::VendorUserDecorator
  def self.prepended(base)
    base.belongs_to :stock_location
  end
end

Spree::VendorUser.prepend(Spree::VendorUserDecorator)