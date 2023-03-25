gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_8'

class TestCodeRepresentation < MiniTest::Test
  def test_code_representation_without_any_characters
    sample_text = '""'

    test_representation = Representation.new(sample_text)
    assert_equal(2, test_representation.code)
  end

  def test_characters_representation_without_any_characters
    sample_text = '""'
    test_representation = Representation.new(sample_text)
    assert_equal(0, test_representation.characters)
  end

  def test_encoded_representation_without_any_characters
    sample_text = '""'
    test_representation = Representation.new(sample_text)
    assert_equal(6, test_representation.encoded)
  end

  def test_code_representation_with_regular_characters
    sample_text = '"abc"'

    test_representation = Representation.new(sample_text)
    assert_equal(5, test_representation.code)
  end

  def test_characters_representation_with_regular_characters
    sample_text = '"abc"'

    test_representation = Representation.new(sample_text)

    assert_equal(3, test_representation.characters)
  end

  def test_encoded_representation_with_regular_characters
    sample_text = '"abc"'
    test_representation = Representation.new(sample_text)
    assert_equal(9, test_representation.encoded)
  end

  def test_code_representation_with_escaped_dquotes
    sample_text = '"aaa\"aaa"'

    test_representation = Representation.new(sample_text)

    assert_equal(10, test_representation.code)
  end

  def test_characters_representation_with_escaped_dquotes
    sample_text = '"aaa\"aaa"'

    test_representation = Representation.new(sample_text)

    assert_equal(7, test_representation.characters)
  end

  def test_encoded_representation_with_escaped_dquotes
    sample_text = '"aaa\"aaa"'
    test_representation = Representation.new(sample_text)
    assert_equal(16, test_representation.encoded)
  end

  def test_code_representation_with_escaped_character
    sample_text = '"\x27"'

    test_representation = Representation.new(sample_text)

    assert_equal(6, test_representation.code)
  end

  def test_characters_representation_with_escaped_character
    sample_text = '"\x27"'

    test_representation = Representation.new(sample_text)

    assert_equal(1, test_representation.characters)
  end

  def test_encoded_representation_with_escaped_character
    sample_text = '"\x27"'

    test_representation = Representation.new(sample_text)

    assert_equal(11, test_representation.encoded)
  end

  def test_my_input
    input = File.readlines('day_8_data.txt').map(&:strip)
    difference = 0
    input.each do |line|
      repr = Representation.new(line)
      difference += repr.code - repr.characters
    end
    assert_equal(1333, difference)
  end

  def test_my_input_part2
    input = File.readlines('day_8_data.txt').map(&:strip)
    difference = 0
    input.each do |line|
      repr = Representation.new(line)
      difference += repr.encoded - repr.code
    end
    assert_equal(2046, difference)
  end
end
