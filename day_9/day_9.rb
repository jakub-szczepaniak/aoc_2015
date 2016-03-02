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
    results = []
    town_list = @location_grid.keys
    town_list.permutation.each do |set|
      candidate = 0
      set.each_cons(2) do |pair|
        candidate += distance(pair[0], pair[1])
      end
      results.push(candidate)
    end
    results.min
  end

  def max_route
    results = []
    town_list = @location_grid.keys
    town_list.permutation.each do |set|
      candidate = 0
      set.each_cons(2) do |pair|
        candidate += distance(pair[0], pair[1])
      end
      results.push(candidate)
    end
    results.max
  end

  private

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
