Deface::Override.new(
  virtual_path: 'spree/admin/shipping_methods/index',
  name: 'Add pickup to shipping method table head',
  insert_before: 'th.actions',
  text: <<-HTML
          <th><%= Spree.t(:available_for_pickup) %></th>
        HTML
)