gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_7'

class TestCircuit < MiniTest::Test
  def test_circuit_can_send_value_to_wire
    test_circuit = Circuit.new
    test_circuit.add_group('14146 -> b')
    assert_equal(14_146, test_circuit.resolve('b'))
  end

  def test_circuit_can_have_more_than_one_wire
    test_circuit = Circuit.new
    test_circuit.add_group('14146 -> b')
    test_circuit.add_group('14 -> ab')

    assert_equal(14, test_circuit.resolve('ab'))
    assert_equal(14_146, test_circuit.resolve('b'))
  end

  def test_throws_exception_for_not_present_symbol
    test_circuit = Circuit.new
    assert_throws InvalidSymbolException do
      test_circuit.resolve('abc')
    end
  end

  def test_circuit_can_have_wire_passthrough_to_other_wire
    test_circuit = Circuit.new
    test_circuit.add_group('14146 -> b')
    test_circuit.add_group('b -> a')

    assert_equal(14_146, test_circuit.resolve('a'))
  end

  def test_circuit_support_NOT_operation
    test_circuit = Circuit.new
    test_circuit.add_group('123 -> b')
    test_circuit.add_group('NOT b -> dg')
    assert_equal(65_412, test_circuit.resolve('dg'))
  end

  def test_circuit_supports_RSHIFT_operation
    test_circuit = Circuit.new
    test_circuit.add_group('456 -> y')
    test_circuit.add_group('y RSHIFT 2 -> g')
    assert_equal(114, test_circuit.resolve('g'))
  end

  def test_circuit_supports_LSHIFT_operation
    test_circuit = Circuit.new
    test_circuit.add_group('123 -> x')
    test_circuit.add_group('x LSHIFT 2 -> f')
    assert_equal(492, test_circuit.resolve('f'))
  end

  def test_circuit_supports_OR_operation
    test_circuit = Circuit.new
    test_circuit.add_group('123 -> x')
    test_circuit.add_group('456 -> y')
    test_circuit.add_group('x OR y -> e')

    assert_equal(507, test_circuit.resolve('e'))
  end

  def test_circuit_support_or_with_literal_number
    test_circuit = Circuit.new
    test_circuit.add_group('123 -> x')
    test_circuit.add_group('x OR 456 -> e')

    assert_equal(507, test_circuit.resolve('e'))
  end

  def test_circuit_supports_AND_operation
    test_circuit = Circuit.new
    test_circuit.add_group('123 -> x')
    test_circuit.add_group('456 -> y')
    test_circuit.add_group('x AND y -> d')

    assert_equal(72, test_circuit.resolve('d'))    
  end

  def test_circuit_supports_or_with_literal_number
    test_circuit = Circuit.new
    test_circuit.add_group('123 -> y')
    test_circuit.add_group('456 AND y -> d')

    assert_equal(72, test_circuit.resolve('d'))
  end

  def test_my_input
    input = File.readlines('day_7_data.txt')
    test_circuit = Circuit.new
    input.each do |wire|
      test_circuit.add_group(wire)
    end
    assert_equal(956, test_circuit.resolve('a'))
  end
end
