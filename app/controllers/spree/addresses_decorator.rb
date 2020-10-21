module Spree::AddressesDecorator

  private

  def address_params
    permitted_address_attributes.push(:lat) unless permitted_address_attributes.include?(:lat)
    permitted_address_attributes.push(:lon) unless permitted_address_attributes.include?(:lon)
    p params.require(:address).permit(permitted_address_attributes)
    params.require(:address).permit(permitted_address_attributes)
  end
end

  Spree::AddressesController.prepend(Spree::AddressesDecorator)
