class LocationGrid
  def initialize
    @location_grid = {}
  end
  
  def add(route)
    cities, dist = route.split(' = ')
    from, _, to = cities.split(' ')
    @location_grid[from] ||= Location.new(from)
    @location_grid[from].add_route(to, dist.to_i)
  end
  def distance(from, to)
    @location_grid[from].distance_to(to)
    
  end
  def min_route
    464
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
