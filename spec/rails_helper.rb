require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'aasm/rspec'
require 'wisper/rspec/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.filter_rails_from_backtrace!

  config.include(Devise::Test::IntegrationHelpers, type: :feature)
  config.include(Wisper::RSpec::BroadcastMatcher, type: :service)
end