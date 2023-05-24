require "spec_helper"

RSpec.describe PierConsoleDetective do
  before(:each) do
    reset_pier_console_detective_to_defaults
  end

  it "has a version number" do
    expect(PierConsoleDetective::VERSION).not_to be nil
  end

  it "has a fixed version number" do
    expect(PierConsoleDetective::VERSION).to eq "0.3.0"
  end

  it "has meaningul defaults set" do
    expect(PierConsoleDetective.logger.class).to eq Logger
    expect(PierConsoleDetective.logger.instance_variable_get(:@logdev).dev).to eq STDOUT
    expect(PierConsoleDetective.logger.instance_variable_get(:@logdev).filename).to eq nil
    expect(PierConsoleDetective.log_tag.call).to eq "#{ENV['USER']}"
    expect(PierConsoleDetective.tag_memoization).to eq true
  end

  it "is possible to override defaults with setup" do
    PierConsoleDetective.setup do |config|
      config.logger = Logger.new('log/test_console.log')
      config.log_tag = -> { 'test_tag' }
      config.tag_memoization = false
    end

    expect(PierConsoleDetective.logger.class).to eq Logger
    expect(PierConsoleDetective.logger.instance_variable_get(:@logdev).dev.class).to eq File
    expect(PierConsoleDetective.logger.instance_variable_get(:@logdev).filename).to eq 'log/test_console.log'
    expect(PierConsoleDetective.log_tag.call).to eq "test_tag"
    expect(PierConsoleDetective.tag_memoization).to eq false
  end
end
