module Spree::AddressDecorator
  def full_address
    [
      address1,
      address2,
      city,
      state_text,
      country.to_s
    ].reject(&:blank?).join(', ')
  end
end

Spree::Address.prepend(Spree::AddressDecorator)