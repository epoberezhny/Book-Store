FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password 'A1qwerty'
    # password_confirmation 'A1qwerty'
    confirmed_at Time.current

    # factory :admin do
    #   admin true
    # end
  end
end
