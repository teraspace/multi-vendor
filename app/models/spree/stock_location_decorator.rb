module Spree::StockLocationDecorator
  def self.prepended(base)
    base.geocoded_by :full_address, latitude: :lat, longitude: :lng
    base.after_validation :geocode, if: ->(obj) { obj.full_address.present? }
  end

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

Spree::StockLocation.prepend(Spree::StockLocationDecorator)