gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_11'

class TestSantaPasswordGeneration < Minitest::Test
  def test_check_current_generation
    assert_equal('abd', 'abc'.succ)
  end

  def test_password_generator_can_be_invoked
    refute_equal(nil, PasswordGenerator.new('abcdefgh'))
  end

  def test_old_password_has_to_be_8_characters_long
    assert_raises StandardError do
      PasswordGenerator.new('abc')
    end
    assert_raises StandardError do
      PasswordGenerator.new('abcdeeeddfff')
    end
  end

  def test_validator_can_be_create
    refute_equal(nil, PasswordValidator.new)
  end

  def test_increased_straight_three_letters_returns_false
    validator = PasswordValidator.new
    assert_equal(false, validator.increased?('abbceffg'))
  end

  def test_increased_straight_three_letters_return_tru
    validator = PasswordValidator.new
    assert_equal(true, validator.increased?('hijklmmn'))
  end
end
