FactoryGirl.define do
  factory :coupon, class: 'ShoppingCart::Coupon' do
    code 'c1o2d3e'
    discount 25
    expire { 1.year.after }

    factory :expired_coupon do
      expire { 1.year.ago }
    end
  end
end
