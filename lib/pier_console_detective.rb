require "pier_console_detective/version"
require "pier_console_detective/mod_attr_accessor"
require "logger"

module PierConsoleDetective
  extend PierConsoleDetective::ModAttrAccessor

  def self.setup
    yield self
  end

  # logger is a logger
  # default value is Logger.new(STDOUT)
  mod_attr_accessor :logger, Logger.new(STDOUT)

  # log_tag is a lambda outputting the tag to tag the log entry
  # default value is the ENV['USER']
  mod_attr_accessor :log_tag, -> { ENV['USER'] }

  # tag_memoization is a boolean to mention if the tag should be memoized or not.
  # default is true
  mod_attr_accessor :tag_memoization, true
end

require 'pier_console_detective/utils'
require 'pier_console_detective/irb'
require 'pier_console_detective/pry'
