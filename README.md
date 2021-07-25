# ConsoleDetective

A gem to track commands typed in rails console along with tagging in realtime. The tags can be used to identify users. This works with plain [pry](https://github.com/pry/pry) and [IRB](https://github.com/ruby/ruby/tree/master/lib/irb) and rails console using pry or IRB. The values for log tags, log format, log file name, and memoization requirements are configurable. 

Pry and IRB both provide options for recordng history. It has a few disadvantages:

1. It is not possible to get the logs in realtime.
2. There are no tagging options available.
3. There is no way to know the time when the command was fired. 
4. If we're connecting to console using ssh, the logs will be lost if the connection is disconnected since the logs are only written only when we exit the session. 

`console_detective` overcomes such disadvantages.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'console_detective'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install console_detective

## Usage

There are meaningful defaults for the config. If you are using rails, run `rails console`. Otherwise, `irb -rconsole_detective` or `pry -I./lib -r console_detective` will load the respective consoles with `console_detective` loaded.

The configs can be overridden by creating a file named `console_detective.rb` with following code.

```ruby
require 'console_detective'

ConsoleDetective.setup do |config|
  # log_file_name is a string/file that mentions the location and name of the file where log will be written.
  # default value is log/console.log
  config.log_file_name      = "log/console.log"

  # log_tags is a lambda outputting the tag to tag the log entry
  # default value is the ENV['USER']
  config.log_tags           = -> { ENV['USER'] }

  # log_format is a lambda which takes tag and command as input and outputs the format in which the log will be entered in the log file
  # default format is a hash of format { :tag => <tag>, :command => <command> }
  config.log_format         = -> (tag, command) { { tag: tag, command: command } }
  
  # tag_memoization is a boolean to mention if the tag should be memoized or not.
  # default is true
  config.tag_memoization    = true
end
```

If you are using rails, place this file in `config/initializers` folder and run `rails console`. Otherwise, `irb -r ./console_detective.rb` or `pry -r ./console_detective.rb` will load the respective consoles with `console_detective` loaded with modified config.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. `bin/console` will run in IRB whereas `PRY=true bin/console` will run with Pry. 

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arunn/console_detective.

