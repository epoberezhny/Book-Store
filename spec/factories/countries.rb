FactoryGirl.define do
  factory :country do
    name { generate(:country_name) }
  end

  sequence :country_name { |n| 'Countr' + ('y' * n) }
end
