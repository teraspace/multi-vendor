# This migration comes from spree_product_assembly (originally 20150303105615)
class CreatePartLineItems < SpreeExtension::Migration[4.2]
  def change
    create_table :spree_part_line_items do |t|
      t.belongs_to :line_item, null: false
      t.belongs_to :variant, null: false
      t.integer :quantity, default: 1
    end
  end
end
