FactoryGirl.define do
  factory :author do
    first_name { FFaker::Name.first_name } #'Alexandr'
    last_name { FFaker::Name.last_name } #'Pushkin'
  end
end
