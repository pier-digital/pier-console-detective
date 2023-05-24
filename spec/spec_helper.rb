require 'pier_console_detective_coverage'
require "bundler/setup"
require 'irb'
require "dummy_console/pry"
require 'byebug'
require "pier_console_detective"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def reset_pier_console_detective_to_defaults
  PierConsoleDetective.setup do |config|
    config.logger           = Logger.new(STDOUT)
    config.log_tag         = -> { ENV['USER'] }
    config.tag_memoization  = true
  end
end