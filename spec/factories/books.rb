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

      factory :book_with_reviews do
        transient do
          reviews_count { rand(1..3) }
        end
  
        after(:create) do |book, evaluator|
          create_list(:review, evaluator.reviews_count, book: book, state: :approved)
        end
      end
    end
  end
end
