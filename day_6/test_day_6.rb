#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_6'

class TestLight < MiniTest::Test
  def test_light_can_be_turn_on
    assert_equal(true, Light.new.on)
  end

  def test_light_can_be_turn_off
    light = Light.new
    light.on

    assert_equal(false, light.off)
  end

  def test_light_can_be_toggled
    light = Light.new

    assert_equal(true, light.toggle)
    assert_equal(false, light.toggle)
  end
end

class TestBrightnessControlLight < MiniTest::Test
  def test_light_has_brightness_zero_at_start
    assert_equal(0, RegulatedLight.new.brightness)
  end

  def test_brightnes_can_be_increased
    test_light = RegulatedLight.new
    test_light.on
    assert_equal(1, test_light.brightness)
  end

  def test_brightnes_can_be_increased_twice
    test_light = RegulatedLight.new
    test_light.on
    test_light.on

    assert_equal(2, test_light.brightness)
  end
  def test_brightnes_can_be_toggled
    test_light = RegulatedLight.new
    test_light.toggle

    assert_equal(2, test_light.brightness)
  end

  def test_brightnes_can_be_decreased
    test_light = RegulatedLight.new
    test_light.on
    test_light.off

    assert_equal(0, test_light.brightness)
  end

  def test_brightnes_can_be_decreased_but_cannot_be_negative
    test_light = RegulatedLight.new
    test_light.off

    assert_equal(0, test_light.brightness)
  end
end

class TestLightingGrid < MiniTest::Test
  def test_grid_initialy_has_zero_lights_lit
    assert_equal(0, LightingGrid.new.lit)
  end

  def test_grid_lights_example_1
    test_grid = LightingGrid.new
    instruction = Instruction.new(0, 0, 999, 999, :on)
    test_grid.process(instruction)
    assert_equal(1_000_000, test_grid.lit)
  end

  def test_grid_lights_example_2
    test_grid = LightingGrid.new
    instruction = Instruction.new(0, 0, 999, 0, :toggle)
    test_grid.process(instruction)
    assert_equal(1_000, test_grid.lit)
  end

  def test_grid_lights_example_3
    test_grid = LightingGrid.new
    instruction = Instruction.new(0, 0, 999, 999, :on)
    test_grid.process(instruction)

    instruction = Instruction.new(499, 499, 500, 500, :off)
    test_grid.process(instruction)
    assert_equal(999_996, test_grid.lit)
  end
end

class TestLightningInstructionParser < MiniTest::Test
  def test_parser_example_1
    test_instruction = 'turn on 226,196 through 599,390'
    received = InstructionParser.new.parse(test_instruction)
    expected = Instruction.new(226, 196, 599, 390, :on)

    assert_equal(expected, received)
  end

  def test_parser_example_2
    test_instruction = 'toggle 0,0 through 999,0'
    received = InstructionParser.new.parse(test_instruction)
    expected = Instruction.new(0, 0, 999, 0, :toggle)

    assert_equal(expected, received)
  end

  def test_parser_example_3
    test_instruction = 'turn off 499,499 through 500,500'
    received = InstructionParser.new.parse(test_instruction)
    expected = Instruction.new(499, 499, 500, 500, :off)

    assert_equal(expected, received)
  end
end

class TestMyInput < MiniTest::Test
  def test_part_one_input
    input = File.readlines('day_6_data.txt')
    grid = LightingGrid.new
    input.each do |input_line|
      instruction = InstructionParser.new.parse(input_line)
      grid.process(instruction)
    end
    assert_equal(400_410, grid.lit)
  end

  def test_part_two_input
    input = File.readlines('day_6_data.txt')
    grid = RegulatedLightningGrid.new
    input.each do |input_line|
      instruction = InstructionParser.new.parse(input_line)
      grid.process(instruction)
    end
    assert_equal(15_343_601, grid.brightness)
  end
end
