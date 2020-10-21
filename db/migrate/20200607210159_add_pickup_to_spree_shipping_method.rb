class AddPickupToSpreeShippingMethod < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_shipping_methods, :pickup, :boolean, default: false
  end
end
