require 'aws-sdk-sns'

module Spree::OrderDecorator
  def self.prepended(base)
    base.attr_accessor :stock_location_id
    base.before_save :copy_stock_location_address
    base.state_machine.after_transition to: :complete, do: :publish_to_queue, if: ->(order) { !order.pickup? }
  end

  def copy_stock_location_address
    if stock_location_id && pickup?
      location = Spree::StockLocation.find(stock_location_id)
      ship_address.address1 = location.address1
      ship_address.address2 = location.address2
      ship_address.city = location.city
      ship_address.state = location.state
      ship_address.country = location.country
      ship_address.save!
    end
  end

  # Setup AWS environment variables to work properly AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION
  def publish_to_queue
    return if enqueued_at.present?

    sns = Aws::SNS::Resource.new
    topic = sns.topics.detect {|t| t.arn.include?('duna_product_orders')}
    
    if topic
      topic.publish({
        message: as_message.to_json
      })
      touch :enqueued_at
    end
  rescue
    nil
  end

  # This should be a completed order, so must have shipments
  def as_message
    shipment = shipments.first
    
    {
      delivery_id: number,
      store_name: shipment.stock_location.name,
      store_address: shipment.stock_location.full_address,
      store_phone: shipment.stock_location.phone,
      store_latlon: {
        lat: shipment.stock_location.lat&.to_s,
        lon: shipment.stock_location.lng&.to_s
      },
      customer_name: ship_address.first_name,
      customer_lastname: ship_address.last_name,
      customer_department: "",
      customer_municipality: "",
      customer_address: ship_address.address1,
      customer_latlon: {
        lat: "",
        lon: "",
      },
      customer_phone: ship_address.phone,
      customer_identification_id:  "",
      customer_phone2: ship_address.alternative_phone,
      observations: special_instructions,
      items: line_items.includes(variant: :product).map {|li|  {id: li.sku, item_type: li.name, item_weight: 0, description: li.description }}
    }
  end
end

Spree::Order.prepend(Spree::OrderDecorator)