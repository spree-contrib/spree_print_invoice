require 'factory_bot'
require 'spree/testing_support/factories'

FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
