#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_5'

class NiceStringValidatortest < MiniTest::Test
  def test_valid_string_contains_at_least_3_vowels
    # It contains at least three vowels (aeiou only)
    assert_equal(true, ThreeVowels.new.valid?('aaa'))
    assert_equal(true, ThreeVowels.new.valid?('basoae'))
    assert_equal(true, ThreeVowels.new.valid?('ugknbfddgicrmopn'))

    assert_equal(false, ThreeVowels.new.valid?('dvszwmarrgswjxmb'))
  end

  def test_valid_string_contain_double_letter_sequence
    # It contains at least one letter that appears twice in a row,
    # like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
    assert_equal(true, ConsecutiveLetters.new.valid?('aaa'))
    assert_equal(true, ConsecutiveLetters.new.valid?('ugknbfddgicrmopn'))

    assert_equal(false, ConsecutiveLetters.new.valid?('jchzalrnumimnmhp'))
  end

  def test_valid_string_does_not_contain_nasty_letters
    # It does not contain the strings ab, cd, pq, or xy, even if they are part
    # of one of the other requirements.
    assert_equal(true, NoNastySequence.new.valid?('aaa'))
    assert_equal(true, NoNastySequence.new.valid?('ugknbfddgicrmopn'))

    assert_equal(false, NoNastySequence.new.valid?('haegwjzuvuyypxyu'))
  end

  def test_my_input_1
    nice = 0
    File.readlines('day_5_data.txt').each do |word|
      nice += 1 unless !ThreeVowels.new.valid?(word) || !ConsecutiveLetters.new.valid?(word) || !NoNastySequence.new.valid?(word)
    end
    assert_equal 255, nice
  end

  def test_valid_string_contains_a_pair_of_letters_twice
    # skip('needs to be checked')
    assert_equal(true, PairOfLetters.new.valid?('xyxy'))
    assert_equal(true, PairOfLetters.new.valid?('aabcdefgaa'))

    assert_equal(false, PairOfLetters.new.valid?('aaa'))
  end

  def test_valid_string_contains_same_letter_twice_with_one_between
    assert_equal(true, DoubleWithBetween.new.valid?('xyx'))
    assert_equal(true, DoubleWithBetween.new.valid?('abcdefeghi'))
    assert_equal(true, DoubleWithBetween.new.valid?('aaa'))

    assert_equal(false, DoubleWithBetween.new.valid?('abc'))
  end

  def test_valid_string_with_new_filters
    assert_equal(true, PairOfLetters.new.valid?('qjhvhtzxzqqjkmpb'))
    assert_equal(true, DoubleWithBetween.new.valid?('qjhvhtzxzqqjkmpb'))
    assert_equal(true, PairOfLetters.new.valid?('xxyxx'), 'Pair of letters missing')
    assert_equal(true, DoubleWithBetween.new.valid?('xxyxx'))
  end

  def test_my_input_2
    nice = 0
    File.readlines('day_5_data.txt').each do |word|
      nice += 1 unless !PairOfLetters.new.valid?(word) || !DoubleWithBetween.new.valid?(word)
    end
    assert_equal 55, nice
  end 
end
