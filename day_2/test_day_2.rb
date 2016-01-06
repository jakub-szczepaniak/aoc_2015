#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_2'

class Day2Test < Minitest::Test
  def test_first_example
    # A present with dimensions 2x3x4 requires 2*6 + 2*12 + 2*8 = 52 square
    # feet of wrapping paper plus 6 square feet of slack,
    # for a total of 58 square feet.
    assert_equal 58, Present.new('2x3x4').paper
  end

  def test_second_example
    # A present with dimensions 1x1x10 requires 2*1 + 2*10 + 2*10 = 42 square
    # feet of wrapping paper plus 1 square foot of slack,
    # for a total of 43 square feet.
    assert_equal 43, Present.new('1x1x10').paper
  end

  def test_input_value
    total_paper = 0
    File.readlines('day_2_data.txt').each do |present|
      total_paper += Present.new(present).paper
    end
    assert_equal 1_588_178, total_paper
  end

  def test_ribbon_example_1
    # A present with dimensions 2x3x4 requires 2+2+3+3 = 10 feet of ribbon to
    # wrap the present plus 2*3*4 = 24 feet of ribbon for the bow,
    # for a total of 34 feet.
    assert_equal 34, Present.new('2x3x4').ribbon
  end

  def test_ribbon_example_2
    # A present with dimensions 1x1x10 requires 1+1+1+1 = 4 feet of ribbon to
    # wrap the present plus 1*1*10 = 10 feet of ribbon for the bow,
    # for a total of 14 feet.
    assert_equal 14, Present.new('1x1x10').ribbon
  end

  def test_ribbon_input_value
    total_ribbon = 0
    File.readlines('day_2_data.txt').each do |present|
      total_ribbon += Present.new(present).ribbon
    end
    assert_equal 3_783_758, total_ribbon
  end
end
