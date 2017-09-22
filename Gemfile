source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use HAML for views
gem 'haml-rails', '~> 0.9'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.2'

gem 'devise'
gem 'omniauth-facebook'
gem 'cancancan'

gem 'carrierwave'
gem 'fog-aws'
gem 'mini_magick'

gem 'wicked'
gem 'aasm'
gem 'kaminari'
gem 'rectify'
gem 'draper'

gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'

gem 'rails_admin'
gem 'rails_admin_aasm'

gem 'simple_form'

gem 'ffaker'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'capybara'#, require: 'capybara/rspec'
  gem 'poltergeist'#, require: 'capybara/poltergeist'
  gem 'spring-commands-rspec'
  gem 'wisper-rspec', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'ruby-debug-ide'
  gem 'debase'
  gem 'figaro'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
