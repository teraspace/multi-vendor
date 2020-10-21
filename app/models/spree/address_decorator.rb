module Spree::AddressDecorator
  Spree::Address::ADDRESS_FIELDS.push("lat") unless Spree::Address::ADDRESS_FIELDS.include?("lat")
  Spree::Address::ADDRESS_FIELDS.push("lon") unless Spree::Address::ADDRESS_FIELDS.include?("lon")
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