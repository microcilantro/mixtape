require 'factory_bot'  # Changed from factory_girl
require 'ffaker'
require 'rspec'
require 'rack/test'

require './app'
require './spec/rb/factories'

Dir['./spec/rb/support/**/*.rb'].each { |f| require(f) }

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods  # Changed from FactoryGirl
  config.order = "random"
end
