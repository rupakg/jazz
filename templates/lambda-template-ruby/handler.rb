# Ruby Lambda Project Template
# handler.rb - Lambda project template in ruby
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

  # Init logging
  logger = Log.new(event: event, context: context, level: :debug)

  logger.info('Logging enabled...')

  # get config values
  config = Config.new(context)
  keyValue = config.get_config('configKey')

  # log config key value
  logger.debug("Config values for 'configKey': #{keyValue}")

  {
    statusCode: 200,
    body: JSON.generate({
      message: 'Your function executed successfully using the Ruby runtime!',
      event: event,
    }),
  }
end
