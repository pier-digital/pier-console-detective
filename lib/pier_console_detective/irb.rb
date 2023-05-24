module PierConsoleDetective
  module IrbLogger
    def evaluate(*args, **kw)
      input = args.first.chomp
      PierConsoleDetective::Utils.log_command(input)
      output = super(*args, **kw)
      PierConsoleDetective::Utils.log_command_output(input, output)
      output
    end
  end
end

IRB::Context.prepend(PierConsoleDetective::IrbLogger) if defined?(IRB::Context)