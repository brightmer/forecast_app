ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "vcr"

module ActiveSupport
  class TestCase < Minitest::Test
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    WebMock.enable!
    VCR.configure do |vcr_config|
      vcr_config.cassette_library_dir = "fixtures/vcr_cassettes"
      vcr_config.hook_into :webmock
    end

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
  end
end
