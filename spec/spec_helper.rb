require "bundler/setup"
require 'webmock/rspec'

require "simple_crawler"
require "simple_crawler/spider"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
