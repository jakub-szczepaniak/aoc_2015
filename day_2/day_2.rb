class Present
  def initialize(dimensions)
    @length, @width, @height = dimensions.split('x').map(&:to_i)
  end

  def paper
    (2 * @length * @width) + (2 * @width * @height) + (2 * @length * @height) + slack
  end

  def ribbon
    bow + wrap
  end

  private

  def slack
    [@length * @width, @width * @height, @height * @length].min
  end

  def bow
    @length * @width * @height
  end
  
  def wrap
    [perimeter(@length, @width), perimeter(@length, @height), perimeter(@height, @width)].min
  end

  def perimeter(a, b)
    (2 * a) + (2 * b)
  end
end
