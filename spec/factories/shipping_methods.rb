FactoryGirl.define do
  factory :shipping_method do
    name { generate(:delivery_name) }
    price 
    min_days 1
    max_days 5
    country

    factory :shipping_method_with_invalid_days do
      min_days 5
      max_days 1
    end
  end

  sequence :delivery_name { |n| "Method#{n}" }
  sequence :price { |n| 5.0 * n }
end
