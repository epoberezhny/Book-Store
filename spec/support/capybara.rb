# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end

require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
# Capybara.default_max_wait_time = 5