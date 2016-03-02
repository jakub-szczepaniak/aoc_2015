require 'ostruct'
class LocationGrid
  def initialize
    @location_grid = {}
  end

  def add(route)
    parsed = parse_route(route)
    insert(parsed.city1, parsed.city2, parsed.dist.to_i)
    insert(parsed.city2, parsed.city1, parsed.dist.to_i)
  end

  def distance(from, to)
    @location_grid[from].distance_to(to)
  end

  def min_route
    collect_totals.min
  end

  def max_route
    collect_totals.max
  end

  private

  def collect_totals
    possible_routes.collect { |route| calculate_total(route) }
  end

  def possible_routes
    @location_grid.keys.permutation
  end

  def calculate_total(route)
    collect_distances(route).inject(0, &:+)
  end

  def collect_distances(route)
    route.each_cons(2).map { |locations| distance(locations[0], locations[1]) }
  end

  def parse_route(route)
    parsed = OpenStruct.new
    cities, parsed.dist = route.split(' = ')
    parsed.city1, _, parsed.city2 = cities.split(' ')
    parsed
  end

  def insert(from, to, distance)
    @location_grid[from] ||= Location.new(from)
    @location_grid[from].add_route(to, distance.to_i)
  end
end

class Location
  attr_reader :name
  def initialize(location)
    @routes = {}
    @name = location
    add_route(@name, 0)
  end

  def distance_to(name)
    fail StandardError unless @routes.keys.include?(name)
    @routes[name]
  end

  def add_route(name, distance)
    @routes[name] = distance
  end
end
