# Ruby API Project Template
# handler.rb - API project template in ruby
#
# Author: 
# Version: 1.0

require 'json'
require_relative 'components/logger'
require_relative 'components/config'

def helloworld(event:, context:)
  # Level hierarchy: DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN

  # Use block form to delay the evaluation of log message until and unless the message is logged, based on logging level.
  # In case of the regular form, the message will always be evaluated, irrespective of if the message will be logged or not based on the current logging level. 

  # logger.debug { "The value of 'foo' is #{foo}" }
  # logger.info("Initializing...")
  # logger.warn("Just a warning!")
  # logger.error { "Argument #{@foo} mismatch." }
  # logger.fatal { "Argument #{foo} not given." }

  begin
    # Init logging
    logger = Log.new(event: event, context: context, level: :debug)

    logger.info('Logging enabled...')

    # get config values
    config = Config.new(context)
    fooValue = config.get_config('foo')
    barValue = config.get_config('bar')

    # log config key values
    logger.debug("Config values for 'foo': #{fooValue}")
    logger.debug("Config values for 'bar': #{barValue}")

    data = {
      foo: fooValue,
      bar: barValue
    }

    case event['method']:
      when 'POST':
        logger.debug("POST recd. with data: #{event['body']}")
      when 'GET':
        logger.debug("GET recd. with query: #{event['query']}")
      else
        logger.debug("#{event['method'].upcase} recd. with input: #{event}")
    end

    # response
    {
      JSON.generate({
        data: data,
        input: event
      })
    }
  rescue StandardError => ex
    logger.fatal {"#{ex.message}\n" + ex.backtrace.join("\n") }

    {
      JSON.generate({
        # Error types: BadRequest, Forbidden, Unauthorized, NotFound, InternalServerError
        errorType: 'InternalServerError',
        message: ex.message,
        input: event
      })
    }
  end
end
