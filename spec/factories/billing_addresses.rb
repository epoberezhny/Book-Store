FactoryGirl.define do
  factory :billing_address, class: 'ShoppingCart::BillingAddress' do
    first_name 'Anton'
    last_name 'Antonov'
    city 'harkov'
    country
    address_line 'billing'
    zip 54321
    phone '+380651112233'
  end
end
