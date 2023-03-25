#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_3'

class Day3Test < Minitest::Test
  def setup
    @house_map = Grid.new
    santa = Santa.new(@house_map)
    @elf = Elf.new([santa])
    @input = File.read('day_3_data.txt')
  end

  def test_example_1
    # > delivers presents to 2 houses: one at the starting location,
    # and one to the east.
    @elf.directions('>')
    assert_equal 2, @house_map.visited_houses
  end

  def test_example_2
    @elf.directions('^>v<')
    assert_equal 4, @house_map.visited_houses
  end

  def test_example_3
    @elf.directions('^v^v^v^v^v')
    assert_equal 2, @house_map.visited_houses
  end

  def test_my_input_part_1
    @elf.directions(@input)
    assert_equal 2592, @house_map.visited_houses
  end

  def test_my_input_part_2
    santa = Santa.new(@house_map)
    robo_santa = Santa.new(@house_map)
    @elf = Elf.new([santa, robo_santa])
    @elf.directions(@input)
    assert_equal 2360, @house_map.visited_houses
  end
end

class GridTest < Minitest::Test
  def setup
    @house_map = Grid.new
  end

  def test_grid_should_have_no_houses_visited_at_start
    assert_equal 0, @house_map.visited_houses
  end

  def test_grid_can_have_one_visited_house
    @house_map.visit 0, 0

    assert_equal 1, @house_map.visited_houses
  end

  def test_grid_can_have_more_visited_houses
    @house_map.visit 0, 0
    @house_map.visit 1, 0

    assert_equal 2, @house_map.visited_houses
  end

  def test_grid_counts_visits_only_once
    @house_map.visit 100, 100
    @house_map.visit 1, 0
    @house_map.visit 100, 100

    assert_equal 2, @house_map.visited_houses
  end
end

class TestSanta < MiniTest::Test
  def setup
    @house_map = MiniTest::Mock.new
    @house_map.expect(:visit, nil, [0, 0])
  end

  def test_santa_should_be_able_to_move_west
    @house_map.expect(:visit, nil, [-1, 0])

    santa = Santa.new(@house_map)
    santa.west
    @house_map.verify
  end

  def test_santa_should_be_able_to_move_west_twice
    @house_map.expect(:visit, nil, [-1, 0])
    @house_map.expect(:visit, nil, [-2, 0])

    santa = Santa.new(@house_map)
    santa.west
    santa.west
    @house_map.verify
  end

  def test_santa_should_be_able_to_move_east_twice
    @house_map.expect(:visit, nil, [1, 0])
    @house_map.expect(:visit, nil, [2, 0])

    santa = Santa.new(@house_map)
    santa.east
    santa.east
    @house_map.verify
  end

  def test_santa_should_be_able_to_move_north_twice
    @house_map.expect(:visit, nil, [0, 1])
    @house_map.expect(:visit, nil, [0, 2])

    santa = Santa.new(@house_map)
    santa.north
    santa.north
    @house_map.verify
  end

  def test_santa_should_be_able_to_move_south_twice
    @house_map.expect(:visit, nil, [0, -1])
    @house_map.expect(:visit, nil, [0, -2])

    santa = Santa.new(@house_map)
    santa.south
    santa.south
    @house_map.verify
  end
end

class TestElf < MiniTest::Test
  def test_elf_commands_north_for_up_arrow
    santa = MiniTest::Mock.new
    santa.expect(:north, nil)
    elf = Elf.new([santa])
    elf.directions('^')
    santa.verify
  end

  def test_elf_commands_south_for_v_arrow
    santa = MiniTest::Mock.new
    santa.expect(:south, nil)
    elf = Elf.new([santa])
    elf.directions('v')
  end

  def test_elf_command_east_for_left_arrow
    santa = MiniTest::Mock.new
    santa.expect(:east, nil)
    elf = Elf.new([santa])
    elf.directions('>')
  end

  def test_elf_command_west_for_left_arrow
    santa = MiniTest::Mock.new
    santa.expect(:west, nil)
    elf = Elf.new([santa])
    elf.directions('<')
  end

  def test_elf_send_santa_west_robo_east
    santa = MiniTest::Mock.new
    santa.expect(:west, nil)
    robo_santa = MiniTest::Mock.new
    robo_santa.expect(:east, nil)

    elf = Elf.new([santa, robo_santa])
    elf.directions('<>')
    santa.verify
    robo_santa.verify
  end
end
