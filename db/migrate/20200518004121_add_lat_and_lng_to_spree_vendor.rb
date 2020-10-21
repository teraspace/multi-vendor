class AddLatAndLngToSpreeVendor < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_vendors, :lat, :decimal, precision: 10, scale: 6
    add_column :spree_vendors, :lng, :decimal, precision: 10, scale: 6
    add_index :spree_vendors, [:lat, :lng]
  end
end
