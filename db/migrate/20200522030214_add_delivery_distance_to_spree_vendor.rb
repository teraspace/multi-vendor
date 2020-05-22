class AddDeliveryDistanceToSpreeVendor < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_vendors, :delivery_distance, :integer, default: 5
  end
end
