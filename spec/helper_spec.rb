ENV['RACK_ENV'] = 'test'

require 'bundler'

Bundler.require
Bundler.require :test

require 'rspec'
require 'rack/test'
require 'database_cleaner'

require './app/core'



RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.color = true
  config.formatter = :documentation



  config.before(:suite) do
    ActiveRecord::Base.logger = nil

    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
