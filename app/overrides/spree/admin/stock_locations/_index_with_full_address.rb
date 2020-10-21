Deface::Override.new(
  virtual_path: 'spree/admin/stock_locations/index',
  name: 'Add stock location full address to index and linked to maps',
  insert_before: '.actions-2',
  text: <<-HTML
        <% if stock_location.google_location %>
          <td><%= link_to stock_location.full_address, stock_location.google_location, target: "_blank" %></td>
        <% else %>
          <td><%= stock_location.full_address %></td>
        <% end %>
        <td><%= stock_location.available_for_pickup? %></td>
        HTML
)