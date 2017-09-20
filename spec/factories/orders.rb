FactoryGirl.define do
  factory :order do
    factory :order_with_items do
      transient do
        items_count 3
      end

      after(:create) do |order, evaluator|
        create_list(:order_item, evaluator.items_count, order: order)
      end

      factory :order_with_addresses do
        after(:create) do |order|
          order.shipping_address = build(:shipping_address)
          order.billing_address  = build(:billing_address)
        end

        factory :order_with_shipping_method do
          shipping_method
        end
      end
    end
  end
end
