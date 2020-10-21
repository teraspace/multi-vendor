class AddPickupToSpreeOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_orders, :pickup, :boolean
  end
end
