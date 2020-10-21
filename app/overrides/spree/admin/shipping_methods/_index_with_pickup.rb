Deface::Override.new(
  virtual_path: 'spree/admin/shipping_methods/index',
  name: 'Add pickup to index table',
  insert_before: '.actions-2',
  text: <<-HTML
        <td><%= shipping_method.pickup %></td>
        HTML
)