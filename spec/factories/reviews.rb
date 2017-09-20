FactoryGirl.define do
  factory :review do
    user
    book
    title 'Title'
    score { rand(1..5) }
    body 'MyText'
  end
end
