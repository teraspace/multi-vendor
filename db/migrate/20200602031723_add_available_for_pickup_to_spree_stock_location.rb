class AddAvailableForPickupToSpreeStockLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_stock_locations, :available_for_pickup, :boolean
  end
end
