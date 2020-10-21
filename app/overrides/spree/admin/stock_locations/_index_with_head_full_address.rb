Deface::Override.new(
  virtual_path: 'spree/admin/stock_locations/index',
  name: 'Add stock location full address header to index',
  insert_before: 'th.actions',
  text: <<-HTML
          <th><%= Spree.t(:full_address) %></th>
          <th><%= Spree.t(:available_for_pickup) %></th>
        HTML
)