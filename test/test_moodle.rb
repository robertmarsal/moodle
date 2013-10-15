require 'test_helper'
require 'moodle'

class MoodleTest < Test::Unit::TestCase
  # Test creating new instance
  def test_new_with_token
    client = Moodle.new(:token => 'test')
    assert client.instance_of?(Moodle::Client)
  end

  # Test that global configuration can be set with hash
  def test_configure
    Moodle.configure({
      :username => 'test_username',
      :password => 'test_password'
    })

    assert_equal 'test_username', Moodle.config[:username]
    assert_equal 'test_password', Moodle.config[:password]
  end

  # Test that global configuration can be set with yaml
  def test_configure_with
    Moodle.configure_with('test/fixtures/config.yml')

    assert_equal 'test_username', Moodle.config[:username]
    assert_equal 'test_password', Moodle.config[:password]
  end
end