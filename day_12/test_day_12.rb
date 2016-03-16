gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_12'

class TestingJSONSumCalculation < MiniTest::Test
  def test_sum_is_zero_for_empty_json
    assert_equal(0, JSONCalc.new('{}').sum)
  end
end
