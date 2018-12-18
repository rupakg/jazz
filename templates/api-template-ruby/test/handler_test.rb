require_relative '../handler.rb'
require 'test/unit'

class TestHandler < Test::Unit::TestCase
  def test_helloworld_post()
    test_data = "{\"a\": \"a-value\", \"b\": \"b-value\" }"
    payload = { "method" => "POST", "body" => test_data }
    response = helloworld(event: payload, context: {aws_request_id: 'TEST11111111'})
    assert_equal 'POST', event['method'] 
    assert_equal 'a-value', event['body']['a'] 
    assert_equal 'b-value', event['body']['b'] 
    assert_equal 'foo-value-dev', response[:foo]
    assert_equal 'bar-value-dev', response[:bar]
  end
  def test_helloworld_get()
    test_data = "{\"a\": \"a-value\", \"b\": \"b-value\" }"
    payload = { "method" => "GET", "query" => test_data }
    response = helloworld(event: payload, context: {aws_request_id: 'TEST11111111'})
    assert_equal 'GET', event['method'] 
    assert_equal 'a-value', event['query']['a'] 
    assert_equal 'b-value', event['query']['b'] 
    assert_equal 'foo-value-dev', response[:foo]
    assert_equal 'bar-value-dev', response[:bar]
  end
end