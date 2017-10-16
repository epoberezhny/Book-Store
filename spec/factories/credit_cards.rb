FactoryGirl.define do
  factory :credit_card, class: 'ShoppingCart::CreditCard' do
    cvv '123'
    number '1111222233334444'
    name_on_card 'Vasya Petya'
    month_year '11/22'
  end
end
