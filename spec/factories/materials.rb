FactoryGirl.define do
  factory :material do
    name { %w[glossy paper hardcove\ paper cardboard].sample }
  end
end
