Deface::Override.new(
  virtual_path: 'spree/admin/orders/index',
  name: 'Add stock location name to orders index as vendor manager admin',
  insert_after: 'erb[loud]:contains("plural_resource_name(Spree::Order)")',
  text: <<-HTML
        <% if current_spree_user.respond_to?(:vendor_ids) && current_spree_user.stock_locations.any? %>
          <span><%= current_spree_user.stock_locations.pluck(:name).to_sentence %></span>
        <% end %>
        HTML
)