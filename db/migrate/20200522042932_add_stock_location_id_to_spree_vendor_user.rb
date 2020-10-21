class AddStockLocationIdToSpreeVendorUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :spree_vendor_users, :stock_location, index: true
  end
end
