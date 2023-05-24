require 'logger'

module PierConsoleDetective
  module Utils
    LOGGER_PROC = ->(command) do
      PierConsoleDetective::Utils.logger.info("Command executed", command: command, tag: PierConsoleDetective::Utils.get_tag)
    end

    def self.logger
      @logger ||= PierConsoleDetective.logger
    end

    def self.get_tag
      return @tag if PierConsoleDetective.tag_memoization && @tag
      @tag = PierConsoleDetective.log_tag.call
    end

    def self.log_command(command, immediately: false)
      return Thread.new { PierConsoleDetective::Utils::LOGGER_PROC.call(command) } unless immediately
      PierConsoleDetective::Utils::LOGGER_PROC.call(command)
    end
  end
end