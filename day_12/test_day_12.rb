gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_12'

class TestingJSONSumCalculation < MiniTest::Test
  def test_sum_is_zero_for_empty_json
    assert_equal(0, JSONCalc.new('{}').sum)
  end

  def test_sum_is_1_for_json_with_array_with_1
    assert_equal(1, JSONCalc.new('[1]').sum)
  end

  def test_sum_is_0_for_empty_array
    assert_equal(0, JSONCalc.new('[]').sum)
  end

  def test_sum_is_one_for_embedded_array
    assert_equal(1, JSONCalc.new('[1, []]').sum)
  end

  def test_sum_is_one_for_single_hash
    assert_equal(1, JSONCalc.new('{"a": 1}').sum)
  end
end
