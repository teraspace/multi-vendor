# This migration comes from spree_product_assembly (originally 20120316141830)
class NamespaceProductAssemblyForSpreeOne < SpreeExtension::Migration[4.2]
  def up
    rename_table :assemblies_parts, :spree_assemblies_parts
  end

  def down
    rename_table :spree_assemblies_parts, :assemblies_parts
  end
end
