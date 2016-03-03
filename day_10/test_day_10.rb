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

  def test_returns_one_one_for_one_as_initial_sequence
    test_sequence = SequenceCalculator.new('1')

    assert_equal('11', test_sequence.calculate)
  end

  def test_returns_2_one_for_one_one
    test_sequence = SequenceCalculator.new('11')

    assert_equal('21', test_sequence.calculate)
  end

  def test_returns_1211_for_21
    test_sequence = SequenceCalculator.new('21')

    assert_equal('1211', test_sequence.calculate)
  end
end
