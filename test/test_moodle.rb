require 'test/unit'
require 'moodle'

class MoodleTest < Test::Unit::TestCase
  def test_new
    client = Moodle.new
    assert client.instance_of?(Moodle::API)
  end
end