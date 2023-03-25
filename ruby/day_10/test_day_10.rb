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

  def test_returns_1211_for_1_when_iterated_3_times
    test_sequence = SequenceCalculator.new('1')

    assert_equal('1211', test_sequence.calculate(3))
  end

  def test_my_input_part_1
    test_sequence = SequenceCalculator.new('3113322113')
    test_sequence.calculate(40)
    assert_equal(329_356, test_sequence.length)
  end

  def test_my_input_part_2
    test_sequence = SequenceCalculator.new('3113322113')
    test_sequence.calculate(50)
    assert_equal(4_666_278, test_sequence.length)
  end
end
