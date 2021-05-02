require_relative '../config/environment'

if Rails.env.test?
  require 'simplecov'
  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter])
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] ||= 'test'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
  end
end
