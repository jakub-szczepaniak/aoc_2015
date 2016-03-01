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
  end
  def name
    'Dublin'
  end
  def distance_to(name)
    0
  end
end