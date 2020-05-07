# This migration comes from spree_product_assembly (originally 20091029165620)
class AddPartsFieldsToProducts < SpreeExtension::Migration[4.2]
  def self.up
    table = if table_exists?(:products)
      'products'
    elsif table_exists?(:spree_products)
      'spree_products'
    end 
    
    change_table(table) do |t|
      t.column :can_be_part, :boolean, :default => false, :null => false
      t.column :individual_sale, :boolean, :default => true, :null => false
    end  
  end

  def self.down
    table = if table_exists?(:products)
      'products'
    elsif table_exists?(:spree_products)
      'spree_products'
    end 
    
    change_table(table) do |t|
      t.remove :can_be_part
      t.remove :individual_sale
    end
  end
end
