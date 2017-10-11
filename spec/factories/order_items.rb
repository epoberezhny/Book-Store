FactoryGirl.define do
  factory :order_item do
    book
    quantity 3
    order
  end
end
