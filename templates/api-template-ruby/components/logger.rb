# Ruby Logging Component
# logger.rb - a simple logging module for ruby
#
# Author: 
# Version: 1.0

require 'logger'

### Usage
# require_relative '../components/logger'

# logger = Log.new(event: event, context: context, level: :debug)
# logger.level = Logger::WARN # or logger.level = :warn

# Level hierarchy: DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN

# Use block form to delay the evaluation of log message until and unless the message is logged, based on logging level.
# In case of the regular form, the message will always be evaluated, irrespective of if the message will be logged or not based on the current logging level. 

# logger.debug { "The value of 'foo' is #{foo}" }
# logger.info("Initializing...")
# logger.warn("Just a warning!")
# logger.error { "Argument #{@foo} mismatch." }
# logger.fatal { "Argument #{foo} not given." }

class Log
  
  def initialize(event: {}, context: {}, level: :info)
    @event = event
    @context = context

    logger = Logger.new(STDOUT)
    logger.level = level
    logger.datetime_format = '%Y-%m-%d %H:%M:%S'
    logger.formatter = proc do |severity, datetime, progname, msg|
      "\n#{datetime} #{context.aws_request_id} #{severity} #{progname} #{msg}"
    end
    @logger = logger
  end

  def level(level)
    @logger.level = level
  end

  def debug(&block)
    @logger.debug(&block)
  end

  def info(&block)
    @logger.info(&block)
  end

  def warn(&block)
    @logger.warn(&block)
  end

  def error(&block)
    @logger.error(&block)
  end

  def fatal(&block)
    @logger.fatal(&block)
  end

end