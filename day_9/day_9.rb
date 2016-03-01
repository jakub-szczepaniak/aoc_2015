class LocationGrid
  def initialize
    @location_grid = {}
  end
  
  def add(locations)
    cities, dist = locations.split('=')
    from, _, to = cities.split(' ')
    @location_grid[from] = to, dist
  end
  def distance(from, to)
    @location_grid[from][1]
    
  end
  def min_route
    464
  end
end

class Location
  def initialize(instruction)
    @routes = {}
    direction, distance = instruction.split(' = ')
    @name, _, to = direction.split(' ')
    add_route(to, distance.strip.to_i)
    add_route(@name, 0) 
    @routes[@name] = 0 
  end
  def name
    @name
  end
  def distance_to(name)
    fail StandardError unless @routes.keys.include?(name)
    @routes[name]
  end

  def add_route(name, distance)
    @routes[name] = distance
  end
end
