FactoryGirl.define do
  factory :country do
    name { generate(:country_name) }
  end

  sequence :country_name { |n| 'Country' * n }
end
