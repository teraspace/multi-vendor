class AddAddressToSpreeVendor < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_vendors, :address, :string
  end
end
