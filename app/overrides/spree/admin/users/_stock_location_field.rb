Deface::Override.new(
  virtual_path: 'spree/admin/users/_form',
  name: 'Add stock location to user form as vendor admin',
  insert_before: 'div[data-hook="admin_user_form_roles"]',
  text: <<-HTML
        <% if current_spree_user.respond_to?(:vendor_ids) && current_spree_user.vendors.active.any? %>
          <%= f.field_container :stock_location_id, class: ['form-group'] do %>
            <%= f.label :stock_location_id, Spree::StockLocation.model_name.human %>
            <%= f.collection_select(:stock_location_id, current_spree_user.stock_locations_by_vendor, :id, :name, { }, { class: 'select2', multiple: false }) %>
          <% end %>
        <% end %>
        HTML
)