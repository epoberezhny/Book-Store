# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

['Mobile development', 'Photo', 'Web design', 'Web development'].reverse_each do |name|
  Category.find_or_create_by!(name: name)
end

['glossy paper', 'hardcove', 'paper', 'cardboard'].each do |name|
  Material.find_or_create_by!(name: name)
end

10.times do
  Author.create! do |author| 
    author.first_name = FFaker::Name.first_name
    author.last_name  = FFaker::Name.last_name
  end
end

categories = Category.all
authors    = Author.all
materials  = Material.all

Category.find_each do |category|
  rand(15..35).times do
    Book.create! do |book|
      book.title       = FFaker::Book.title
      book.price       = rand(10.00..50.00)
      book.quantity    = rand(0..10)
      book.description = FFaker::Book.description
      book.year        = rand(1980..2017)
      book.category    = categories.sample
      book.authors     = authors.sample( rand(1..3) )
      book.materials   = materials.sample( rand(1..3) )
      book.dimensions  = {
        'h' => rand(1.0..10.0).round(1),
        'w' => rand(1.0..10.0).round(1),
        'd' => rand(1.0..10.0).round(1)
      }
    end
  end
end

Country.find_or_create_by!(name: 'Ukraine') do |country|
  country.shipping_methods.build(name: 'Standard Shipping', price: 5.0, min_days: 5, max_days: 7)
  country.shipping_methods.build(name: 'Fast Shipping', price: 10.0, min_days: 1, max_days: 3)
end

Country.find_or_create_by!(name: 'USA') do |country|
  country.shipping_methods.build(name: 'International Shipping', price: 20.0, min_days: 10, max_days: 15)
end

Coupon.create!(code: 'awesome_bookstore', expire: 6.months.after, discount: 25)
Coupon.create!(code: 'coupn', expire: 6.months.before, discount: 25)
