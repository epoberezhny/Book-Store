FactoryGirl.define do
  factory :country, class: 'ShoppingCart::Country' do
    name { generate(:country_name) }
  end

  sequence :country_name { |n| 'Countr' + ('y' * n) }
end
