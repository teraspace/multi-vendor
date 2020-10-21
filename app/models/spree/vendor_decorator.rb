module Spree::VendorDecorator
  def self.prepended(base)
    base.geocoded_by :address, latitude: :lat, longitude: :lng
    base.after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }
  end
end

Spree::Vendor.prepend(Spree::VendorDecorator)