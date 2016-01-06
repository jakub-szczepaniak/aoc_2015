class Grid
  def initialize
    @visits = 0
    @houses = {}
  end

  def visited_houses
    @visits
  end

  def visit(x, y)
    coordinate = "#{x}#{y}"
    mark_visit(coordinate) unless @houses.key?(coordinate)
  end

private

  def mark_visit(position)
    @houses[position] = true
    @visits += 1
  end
end

class Santa
  def initialize(grid)
    @x = 0
    @y = 0
    @grid = grid
    visit
  end

  def north
    @y += 1
    visit
  end

  def east
    @x += 1
    visit
  end

  def west
    @x -= 1
    visit
  end

  def south
    @y -= 1
    visit
  end

  private

  def visit
    @grid.visit(@x, @y)
  end
end

class Elf
  def initialize(santas)
    @santas = santas.cycle
  end

  def directions(directions)
    directions.chars.each do |direction|
      santa = @santas.next
      case direction
      when '^'
        santa.north
      when '<'
        santa.west
      when '>'
        santa.east
      when 'v'
        santa.south
      end
    end
  end
end
