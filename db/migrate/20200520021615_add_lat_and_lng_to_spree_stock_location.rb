class AddLatAndLngToSpreeStockLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_stock_locations, :lat, :decimal, precision: 10, scale: 6
    add_column :spree_stock_locations, :lng, :decimal, precision: 10, scale: 6
    add_index :spree_stock_locations, [:lat, :lng]
  end
end
