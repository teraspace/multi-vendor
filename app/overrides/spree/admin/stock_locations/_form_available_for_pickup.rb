Deface::Override.new(
  virtual_path: 'spree/admin/stock_locations/_form',
  name: 'Add available for pickup to stock location',
  insert_bottom: '[data-hook="stock_location_status"]',
  text: <<-HTML
        <div class="checkbox my-2" data-hook="stock_location_available_for_pickup">
          <%= label_tag :available_for_pickup do %>
            <%= f.check_box :available_for_pickup %>
            <%= Spree.t(:available_for_pickup) %>
          <% end %>
        </div>
        HTML
)