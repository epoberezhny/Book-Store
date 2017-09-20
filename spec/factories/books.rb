FactoryGirl.define do
  factory :book do
    title { FFaker::Book.title }
    price 9.99
    description 'awesome book'
    quantity 10
    year 2017
    dimensions({ 'h' => '1.1', 'w' => '2.2', 'd' => '3.3' })
    category

    factory :book_with_authors do
      transient do
        authors_count { rand(1..3) }
      end

      after(:create) do |book, evaluator|
        create_list(:author, evaluator.authors_count, books: [book])
      end
    end
  end
end

# title        { FFaker::Book.title }
# price        { rand(10.00..20.00) }
# quantity     { rand(0..10) }
# description  { FFaker::Book.description }
# year         { rand(1980..2017) }
# category     'categories.sample'
# authors      'pushkin'
# materials    'paper'
# dimensions   do { 'h' => rand(1.0..10.0).round(1),
#                   'w' => rand(1.0..10.0).round(1),
#                   'd' => rand(1.0..10.0).round(1) }
# end
