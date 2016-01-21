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
end
