FactoryBot.define do
  factory :invoiceable_order, class: Spree::Order do
    user
    bill_address
    ship_address
    completed_at { nil }
    email { user.email }
    state { 'confirm' }
    store

    transient do
      line_items_count { 1 }
      line_items_price { 10 }
      shipment_cost { 100 }
      shipping_method_filter { Spree::ShippingMethod::DISPLAY_ON_FRONT_END }
    end

    after(:create) do |order, evaluator|
      create_list(:line_item, evaluator.line_items_count, order: order, price: evaluator.line_items_price)
      order.line_items.reload

      create(:shipment, order: order, cost: evaluator.shipment_cost)
      order.shipments.reload
      order.next
    end
  end
end

FactoryBot.modify do
  factory :order_ready_to_ship, class: Spree::Order do
    ship_address { nil }

    after(:create) do |order, _|
      order.ship_address = create(:ship_address, user: order.user)
    end
  end
end
