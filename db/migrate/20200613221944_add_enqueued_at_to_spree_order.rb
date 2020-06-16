class AddEnqueuedAtToSpreeOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_orders, :enqueued_at, :datetime
  end
end
