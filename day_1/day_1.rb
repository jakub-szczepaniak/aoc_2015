class Floor
  def initialize
    @level = 0
  end

  def level(brackets)
    brackets.chars.each do |f|
      up if f == '('
      down if f == ')'
    end
    @level
  end

  def basement(brackets)
    brackets.chars.each_with_index do |f, index|
      up if f == '('
      down if f == ')'
      return index + 1 if @level < 0
    end
  end

  private

  def up
    @level += 1
  end

  def down
    @level -= 1
  end
end
