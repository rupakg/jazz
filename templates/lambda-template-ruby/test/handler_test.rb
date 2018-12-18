require_relative '../handler.rb'
require 'test/unit'

class TestHandler < Test::Unit::TestCase
  def test_helloworld()
    response = helloworld(event: {}, context: {})
    assert_equal 200, response[:statusCode]
    assert_match /Your function executed successfully/, response[:body]
  end
  def test_get_dev_config()
    response = helloworld(event: {}, context: { "function_name" => "test-function-dev" })
    config = Config.new(context)
    keyValue = config.get_config('configKey')  
    assert_equal 'ConfigValueDev', keyValue
  end
  def test_get_stg_config()
    response = helloworld(event: {}, context: { "function_name" => "test-function-stg" })
    config = Config.new(context)
    keyValue = config.get_config('configKey')  
    assert_equal 'ConfigValueStg', keyValue
  end
  def test_get_prod_config()
    response = helloworld(event: {}, context: { "function_name" => "test-function-prod" })
    config = Config.new(context)
    keyValue = config.get_config('configKey')  
    assert_equal 'ConfigValueProd', keyValue
  end
end