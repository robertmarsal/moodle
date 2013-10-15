require 'test_helper'
require 'moodle/client'

class ClientTest < Test::Unit::TestCase
  # Test initialization with hash
  def test_initialize_with_hash
    client = Moodle::Client.new({
      :username => 'test_username',
      :password => 'test_password',
      :domain   => 'test_domain',
      :protocol => 'test_protocol',
      :service => 'test_service',
      :format => 'test_format',
      :token => 'test_token'
    })

    assert_equal 'test_username', client.username
    assert_equal 'test_password', client.password
    assert_equal 'test_domain', client.domain
    assert_equal 'test_protocol', client.protocol
    assert_equal 'test_service', client.service
    assert_equal 'test_format', client.format
    assert_equal 'test_token', client.token
  end

  # Test obtaining a token
  def test_obtain_token
    client = Moodle::Protocol::Rest.new
    client.stubs(:request).returns('{"token" : "12345"}')
    moodle_client = Moodle::Client.new({:token => 'dummy', :domain => 'test'})
    moodle_client.stubs(:client).returns(client)
    assert_equal '12345', moodle_client.obtain_token()
  end
end