gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'day_9'

class TestAddingLocationToGrid < MiniTest::Test
  def test_create_location_grid
    test_grid = LocationGrid.new
    refute_equal(nil, test_grid)
  end

  def test_add_locations_to_grid
    test_grid = LocationGrid.new
    test_grid.add('London to Dublin = 464')
    assert_equal(464, test_grid.distance('London', 'Dublin'))
  end

  def test_when_route_is_added_it_adds_both_locations_to_grid
    test_grid = LocationGrid.new
    test_grid.add('London to Dublin = 464')
    assert_equal(464, test_grid.distance('Dublin', 'London'))
  end
  def test_add_more_than_two_locations_to_grid
    test_grid = LocationGrid.new
    test_grid.add('London to Dublin = 464')
    test_grid.add('London to Belfast = 518')

    assert_equal(464, test_grid.distance('London', 'Dublin'))
    assert_equal(518, test_grid.distance('London', 'Belfast'))
  end
end

class TestCalculateMinimalRoute < MiniTest::Test
  def test_calculate_minimum_for_pair_of_locations
    locations = LocationGrid.new
    locations.add('London to Dublin = 464')

    assert_equal(464, locations.min_route)
  end
end

class TestLocationActions < MiniTest::Test
  def test_it_is_possible_to_create_new_location
    location = Location.new('Dublin')
    refute_equal(nil, location)
  end
  def test_location_knows_its_name
    location = Location.new('Dublin')
    assert_equal('Dublin', location.name)
  end
  def test_location_knows_distance_to_itself_is_zero
    location = Location.new('Dublin')
    assert_equal(0, location.distance_to('Dublin'))
  end
  def test_location_raises_exception_when_it_does_not_know_route_to_city
    location = Location.new('Dublin')
    location.add_route('Belfast', 418)
    assert_raises StandardError do
      location.distance_to('London')
    end
  end
  def test_location_knows_distance_to_other_location
    location = Location.new('Dublin')
    location.add_route('Belfast', 418)
    assert_equal(418, location.distance_to('Belfast'))
  end
  def test_location_can_have_more_than_one_route
    location = Location.new('Dublin')
    location.add_route('Belfast', 418)
    location.add_route('London', 517)
    assert_equal(517, location.distance_to('London'))
    assert_equal(418, location.distance_to('Belfast'))
  end
end
