# Ruby Configuration Component
# config.rb - a simple config management module for ruby
#
# Author: 
# Version: 1.0

require 'yaml'

class Config
  def initialize(context: {})
    @context = context
  end

  def self.load_stage_config
    function_name = @context.function_name
    # Add config key/value pairs in the respective config files
    # and they would be available in handler function.
    stage = function_name.rpartition('-')[2]
    config = YAML.load_file("../config/#{stage}-config.yaml")
  end

  def get_config(key)
    # {"configKey"=>"ConfigValueDev"}
    stage_config = self.load_stage_config()
    config.select{|k,v| k == key}[key]
  end  
end
