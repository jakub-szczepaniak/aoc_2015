gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_10'

class TestLookAndSaySequence < MiniTest::Test
  def test_it_is_possible_to_get_sequence_calculator
    refute_equal(nil, SequenceCalculator.new('1221'))
  end

  def test_it_fails_for_empty_sequence
    assert_raises StandardError do
      SequenceCalculator.new('')
    end
  end

  def test_it_fails_for_non_numeric_sequence
    assert_raises StandardError do
      SequenceCalculator.new('123abc')
    end
  end
end
