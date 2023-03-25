#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_1'

class Day1Test < Minitest::Test
  def test_equal_number_of_brackets_1
    assert_equal 0, Floor.new.level('(())')
  end

  def test_equal_number_of_brackets_2
    assert_equal 0, Floor.new.level('()()')
  end

  def test_positive_number_of_brackets_3
    assert_equal 3, Floor.new.level('(((')
  end

  def test_positive_number_of_brackets_2
    assert_equal 3, Floor.new.level('))(((((')
  end

  def test_negative_number_of_brackets_1
    assert_equal(-1, Floor.new.level('())'))
  end

  def test_my_input_part_1
    my_input = File.read('day_1_data.txt')
    assert_equal 232, Floor.new.level(my_input)
  end

  def test_first_time_in_basement_at_one
    assert_equal 1, Floor.new.basement(')')
  end

  def test_first_time_in_basement_at_five
    assert_equal 5, Floor.new.basement('()())')
  end

  def test_my_input_part_2
    my_input = File.read('day_1_data.txt')
    assert_equal 1783, Floor.new.basement(my_input)
  end
end
