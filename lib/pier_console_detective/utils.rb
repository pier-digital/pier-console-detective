require 'logger'

module PierConsoleDetective
  module Utils
    LOGGER_PROC = ->(message, data) do
      PierConsoleDetective::Utils.logger.info(message, {
        data: data,
        tag: PierConsoleDetective::Utils.get_tag,
      })
    end

    def self.logger
      @logger ||= PierConsoleDetective.logger
    end

    def self.get_tag
      return @tag if PierConsoleDetective.tag_memoization && @tag
      @tag = PierConsoleDetective.log_tag.call
    end

    def self.log_command(command, immediately: false)
      return Thread.new { 
        PierConsoleDetective::Utils::LOGGER_PROC.call("Command executed", {
          command: command.inspect
        }) 
      } unless immediately
      PierConsoleDetective::Utils::LOGGER_PROC.call("Command executed", {
        command: command.inspect
      })
    end

    def self.log_command_output(command, output, immediately: false)
      return Thread.new {
        PierConsoleDetective::Utils::LOGGER_PROC.call("Command outputed", {
          command: command.inspect,
          output: output.inspect,
        })
      } unless immediately
      PierConsoleDetective::Utils::LOGGER_PROC.call("Command outputed", {
        command: command.inspect,
        output: output.inspect,
      })
    end
  end
end