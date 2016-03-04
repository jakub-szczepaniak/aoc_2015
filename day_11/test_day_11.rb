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
end
