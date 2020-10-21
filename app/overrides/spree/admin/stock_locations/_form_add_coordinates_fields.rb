Deface::Override.new(
  virtual_path: 'spree/admin/stock_locations/_form',
  name: 'Add coordinates fields to stock location form',
  insert_bottom: '[data-hook="admin_stock_locations_form_fields"]',
  text: <<-HTML
        <div class="form-group" data-hook="stock_location_lat">
          <%= f.label :lat, Spree.t(:latitude) %>
          <%= f.text_field :lat, class: 'form-control' %>
        </div>
        <div class="form-group" data-hook="stock_location_lng">
          <%= f.label :lng, Spree.t(:longitude) %>
          <%= f.text_field :lng, class: 'form-control' %>
        </div>
        HTML
)