gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_7'

class TestCircuit < MiniTest::Test
  def test_circuit_can_send_value_to_wire
    test_circuit = Circuit.new
    test_circuit.add_wire('14146 -> b')
    assert_equal(14_146, test_circuit.resolve('b'))
  end

  def test_circuit_can_have_more_than_one_wire
    test_circuit = Circuit.new
    test_circuit.add_wire('14146 -> b')
    test_circuit.add_wire('14 -> ab')

    assert_equal(14, test_circuit.resolve('ab'))
    assert_equal(14_146, test_circuit.resolve('b'))
  end
end
