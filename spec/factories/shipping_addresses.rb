FactoryGirl.define do
  factory :shipping_address, class: 'ShoppingCart::ShippingAddress' do
    first_name 'Mishs'
    last_name 'Mishev'
    city 'dnepr'
    country
    address_line 'shipping'
    zip 12345
    phone '+380651112233'
  end
end
