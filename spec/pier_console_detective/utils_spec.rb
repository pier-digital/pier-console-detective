require "spec_helper"

RSpec.describe PierConsoleDetective::Utils do
  before(:each) do
    [:@logger, :@tag].each do |variable|
      PierConsoleDetective::Utils.remove_instance_variable(variable) if PierConsoleDetective::Utils.instance_variables.include?(variable)
    end
    reset_pier_console_detective_to_defaults
  end

  it "sets up logger object with default filename" do
    expect(PierConsoleDetective::Utils.instance_variables).to be_empty
    logger = PierConsoleDetective::Utils.logger
    expect(logger).to eq PierConsoleDetective.logger
    expect(PierConsoleDetective::Utils.instance_variables).to eq [:@logger]
    expect(PierConsoleDetective::Utils.logger).to eq logger
  end

  it "sets up logger object with overriden filename" do
    PierConsoleDetective.setup do |config|
      config.logger = Logger.new('log/test_console.log')
    end
    expect(PierConsoleDetective::Utils.instance_variables).to be_empty
    logger = PierConsoleDetective::Utils.logger
    expect(logger.instance_variable_get(:@logdev).filename).to eq "log/test_console.log"
  end

  it "gets tag based on default config setup and is memoized" do
    expect(PierConsoleDetective::Utils.instance_variables).to be_empty
    expect(PierConsoleDetective::Utils.get_tag).to eq "#{ENV['USER']}"
    PierConsoleDetective.setup do |config|
      config.log_tag = -> { 'nothing' }
    end
    expect(PierConsoleDetective::Utils.get_tag).to eq "#{ENV['USER']}"
  end

  it "gets tag based on modified setup and no memoization" do
    expect(PierConsoleDetective::Utils.instance_variables).to be_empty
    expect(PierConsoleDetective::Utils.get_tag).to eq "#{ENV['USER']}"
    PierConsoleDetective.setup do |config|
      config.tag_memoization = false
      config.log_tag = -> { 'nothing' }
    end
    expect(PierConsoleDetective::Utils.get_tag).to eq "nothing"
  end

  it "calls logger with tag and command in a thread if immediately is false" do
    logger = PierConsoleDetective::Utils.logger
    expect(logger).to receive(:info).with("Command executed", {
      tag: ENV['USER'],
      data: { command: '"command_test"' },
    })
    thr = PierConsoleDetective::Utils.log_command("command_test")
    expect(thr).to be_a(Thread)
    thr.join
    while(thr.alive?)
      sleep(0.1)
    end
  end

  it "calls logger with tag and command if immediately is true" do
    logger = PierConsoleDetective::Utils.logger
    expect(logger).to receive(:info).with("Command executed", {
      tag: ENV['USER'], 
      data: { command: '"command_test"' }
    })
    thr = PierConsoleDetective::Utils.log_command("command_test", immediately: true)
    expect(thr).not_to be_a(Thread)
  end
end