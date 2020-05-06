# This migration comes from spree_product_assembly (originally 20150219192418)
class AddVariantSelectionDeferredToAssembliesParts < SpreeExtension::Migration[4.2]
  def change
    add_column :spree_assemblies_parts, :variant_selection_deferred, :boolean
  end
end
