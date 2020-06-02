# docker-compose exec web bundle exec rails runner db/seeds/store.rb

require 'csv'
require 'mini_magick'

noimage_sizes = {
  mini: "48x48!",
  small: "100x100!",
  product: "240x240!",
  large: "400x400!"
}

default_store = Spree::Store.find_by(default: true)

if default_store
  puts 'Overriding default store attributes'
  default_store.default_currency = "HNL"
  default_store.name = "D-UNA Ecommerce"
  default_store.seo_title = "D-UNA Ecommerce"
  default_store.meta_description = "D-UNA Ecommerce"
  default_store.save
end

# Copy logo to assets folder and setup initializer
logos = Dir.glob(Rails.root.join('db', 'seeds', 'images', 'logo*'))
if logos.any?
  puts "Configurando logo en backend y frontend"
  logo = logos.first
  FileUtils.cp logo, Rails.root.join('app', 'assets', 'images', File.basename(logo))

  image = MiniMagick::Image.open(Rails.root.join(logo))
  if image
    noimage_sizes.each do |name, size|
      puts "- Creando imagen por defecto producto tamaño #{name}"
      image.resize size
      image.write Rails.root.join('app', 'assets', 'images', 'noimage', "#{name}.png")
    end
  end

  Spree::Config[:logo] = File.basename(logo)
  Spree::Config[:admin_interface_logo] = File.basename(logo)
else
  puts "No se encontraron logos en carpeta 'db/seeds/images'"
end

# Taxonomies
# taxonomies = {
#   'Menú' => ["Appetizers To Share", "Wings", "Salads", "Sandwiches & Soups", "Big Mouth Burgers", "Full-On Fajitas", "Fresh Mex", "Baby Back Ribs", "Parrilladas", "Steaks", "Hand-Batter Crispers", "Pastas Chicken & Seafood", "Guiltless Grill", "Sweet Stuff", "Kids Menu", "3 Para Mí", "Meal Para 2", "Bebidas"],
#   'Promociones' => ["Meal Para 1", "Jueves De Margaritas", "Meal Para 2", "El Cumpleañero Come GRATIS", "Niños Comen Gratis", "Tragos Desde L49"]
# }

# taxonomies.each do |root, taxons|
#   puts "- Creando taxonomia #{root}"
#   taxonomy = Spree::Taxonomy.find_or_create_by(name: root)
#   taxons.each do |name|
#     puts "-- Creando taxon #{name}"
#     taxon = Spree::Taxon.find_by(taxonomy_id: taxonomy.id, name: name)
#     unless taxon
#       taxon = Spree::Taxon.create(name: name, taxonomy: taxonomy, parent: taxonomy.root)
#     end

#     taxonomy.root.children << taxon
#   end
# end

# Spree::Taxon.rebuild!

# Load csv and import products

files = Dir.glob(Rails.root.join('db', 'seeds', 'csv', '*.csv'))
if files.any?
  table = CSV.parse(File.read(files.first), headers: true)

  table.each do |row|
    puts "- Creando producto #{row[1]}"
    product = Spree::Product.joins(:master).find_by spree_variants: { sku: row[0] }
 
    product_params = {
      sku: row[0],
      name: row[1].titleize,
      description: row[2],
      price: row[3].to_i,
      available_on: Time.zone.now,
      shipping_category: Spree::ShippingCategory.first
    }

    if product.present?
      @product = Spree::Core::Importer::Product.new(product, product_params).update
    else
      @product = Spree::Core::Importer::Product.new(nil, product_params).create
    end
 
    if @product.persisted?
      if row[4].present?
        vendor = Spree::Vendor.find_or_create_by(name: row[4])
        stock_location = Spree::StockLocation.find_or_create_by(name: row[5]) 
        vendor.stock_locations << stock_location unless vendor.stock_locations.include?(stock_location)
        vendor.products << @product unless vendor.products.include?(@product)
        if row[6].present? && row[6].to_i > 0
          product.master.stock_items.find_or_create_by(stock_location: stock_location).tap do |stock_item|
            stock_item.count_on_hand = row[6].to_i
            stock_item.save
          end
        end
      end
    else
      raise @product.errors.full_messages.to_sentence
    end
  end
end

