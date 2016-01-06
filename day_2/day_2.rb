class Present
  def initialize(input)
    @length, @width, @height = extract_dimensions(input)
  end

  def paper
    2 * (top + front + side) + slack
  end

  def ribbon
    bow + wrap
  end

  private

  def extract_dimensions(input)
    input.split('x').map(&:to_i)
  end

  def front
    @width * @height
  end

  def side
    @height * @length
  end

  def top
    @length * @width
  end

  def slack
    [top, front, side].min
  end

  def bow
    @length * @width * @height
  end

  def wrap
    [perimeter(@length, @width), perimeter(@length, @height), perimeter(@height, @width)].min
  end

  def perimeter(a, b)
    2 * (a + b)
  end
end
