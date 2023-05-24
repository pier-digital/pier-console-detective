require "spec_helper"

RSpec.describe ConsoleDetective do
  before(:each) do
    reset_pier_console_detective_to_defaults
  end

  it "has a version number" do
    expect(ConsoleDetective::VERSION).not_to be nil
  end

  it "has a fixed version number" do
    expect(ConsoleDetective::VERSION).to eq "0.3.0"
  end

  it "has meaningul defaults set" do
    expect(ConsoleDetective.logger.class).to eq Logger
    expect(ConsoleDetective.logger.instance_variable_get(:@logdev).dev).to eq STDOUT
    expect(ConsoleDetective.logger.instance_variable_get(:@logdev).filename).to eq nil
    expect(ConsoleDetective.log_tag.call).to eq "#{ENV['USER']}"
    expect(ConsoleDetective.tag_memoization).to eq true
  end

  it "is possible to override defaults with setup" do
    ConsoleDetective.setup do |config|
      config.logger = Logger.new('log/test_console.log')
      config.log_tag = -> { 'test_tag' }
      config.tag_memoization = false
    end

    expect(ConsoleDetective.logger.class).to eq Logger
    expect(ConsoleDetective.logger.instance_variable_get(:@logdev).dev.class).to eq File
    expect(ConsoleDetective.logger.instance_variable_get(:@logdev).filename).to eq 'log/test_console.log'
    expect(ConsoleDetective.log_tag.call).to eq "test_tag"
    expect(ConsoleDetective.tag_memoization).to eq false
  end
end
