class Spree::VendorsController < Spree::StoreController
  include Spree::FrontendHelper
  helper 'spree/products'
  
  def show
    @vendor = Spree::Vendor.friendly.find(params[:id])
    @searcher = build_searcher(params.merge(vendor: @vendor.id, include_images: true))
    @products = @searcher.retrieve_products.merge(@vendor.products)
  end
end
