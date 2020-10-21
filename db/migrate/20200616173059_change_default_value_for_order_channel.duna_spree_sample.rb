# This migration comes from duna_spree_sample (originally 20200612011413)
class ChangeDefaultValueForOrderChannel < ActiveRecord::Migration[5.2]
  def up
    change_column_default :spree_orders, :channel, 'd-una'
  end

  def down
    change_column_default :spree_orders, :channel, 'spree'
  end
end