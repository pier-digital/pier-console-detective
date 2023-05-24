module PierConsoleDetective
  module IrbLogger
    def evaluate(*args, **kw)
      PierConsoleDetective::Utils.log_command(args.first.chomp)
      super(*args, **kw)
    end
  end
end

IRB::Context.prepend(PierConsoleDetective::IrbLogger) if defined?(IRB::Context)