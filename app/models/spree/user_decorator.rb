module Spree::UserDecorator
  def self.prepended(base)
    base.has_many :stock_locations, through: :vendor_users
    base.attr_accessor :stock_location_id
  end

  def stock_location_id=(location_id)
    stock_location = Spree::StockLocation.find(location_id)
    vendor_user = vendor_users.find_or_initialize_by(user_id: self.id, vendor_id: stock_location.vendor_id)
    vendor_user.stock_location_id = location_id
    vendor_user.save
  end

  def stock_locations_by_vendor
    Spree::StockLocation.where(vendor_id: vendor_ids)
  end
end

Spree::User.prepend(Spree::UserDecorator)