require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
  add_group 'Controllers', 'app/controllers'
  add_group 'Overrides', 'app/overrides'
  add_group 'Libraries', 'lib'
end

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'ffaker'

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }
