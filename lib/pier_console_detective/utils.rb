require 'logger'

module ConsoleDetective
  module Utils
    LOGGER_PROC = ->(command) do
      ConsoleDetective::Utils.logger.info("Command executed", command: command, tag: ConsoleDetective::Utils.get_tag)
    end

    def self.logger
      @logger ||= ConsoleDetective.logger
    end

    def self.get_tag
      return @tag if ConsoleDetective.tag_memoization && @tag
      @tag = ConsoleDetective.log_tag.call
    end

    def self.log_command(command, immediately: false)
      return Thread.new { ConsoleDetective::Utils::LOGGER_PROC.call(command) } unless immediately
      ConsoleDetective::Utils::LOGGER_PROC.call(command)
    end
  end
end