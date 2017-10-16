FactoryGirl.define do
  factory :order_item, class: 'ShoppingCart::OrderItem' do
    # book
    association :product, factory: :book
    quantity 3
    order
  end
end
