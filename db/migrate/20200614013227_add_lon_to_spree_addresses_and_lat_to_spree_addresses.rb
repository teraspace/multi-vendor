class AddLonToSpreeAddressesAndLatToSpreeAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_addresses, :lon, :decimal, precision: 10, scale: 6
    add_column :spree_addresses, :lat, :decimal, precision: 10, scale: 6
  end
end
