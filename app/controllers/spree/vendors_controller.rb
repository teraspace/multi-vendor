class Spree::VendorsController < Spree::StoreController
  include Spree::FrontendHelper
  helper 'spree/products'

  def index
    @vendors = Spree::Vendor.active
    if session[:coords].present?
      @near_vendors = Spree::Vendor.near([session[:coords]["latitude"], session[:coords]["longitude"]], 5, units: :km)
    end
  end
  
  def show
    @vendor = Spree::Vendor.active.friendly.find(params[:id])
    @searcher = build_searcher(params.merge(vendor: @vendor.id, include_images: true))
    @products = @searcher.retrieve_products.merge(@vendor.products)
  end
end
