if Rails.env.test?
  require "simplecov"
  # NOTE-truggeri-20190616 Exempting these as there's no code in them yet
  EXEMPT_CLASSES = %w[channels jobs mailers].freeze
  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter])
  SimpleCov.start 'rails' do
    EXEMPT_CLASSES.each { |dir| add_filter "app/#{dir}/" }
  end
end

ENV['RAILS_ENV'] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
  end
end
