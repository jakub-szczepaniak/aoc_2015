class InvalidSymbolException < Exception
end
class Gate
  def initialize(instruction = nil, grid = nil)
    @output = nil
    @grid = grid
  end

  def convert_to_int_or_evaluate(argument)
    if argument =~ /\d+/
      operand = argument.to_i
    else
      operand = @grid[argument].evaluate
    end
    operand
  end

  def reset
    @output = nil
  end
end
class LShiftGate < Gate
  def initialize(instruction, grid)
    super(instruction, grid)
    @symbol, _, @operand = instruction.split
  end

  def evaluate
    @output ||= (@grid[@symbol].evaluate << @operand.to_i) & 65_535
  end
end
class RshiftGate < Gate
  def initialize(instruction, grid)
    super(instruction, grid)
    @symbol, _, @operand = instruction.split
  end

  def evaluate
    @output ||= (@grid[@symbol].evaluate >> @operand.to_i) & 65_535
  end
end
class LiteralValue < Gate
  def initialize(instruction, gate = nil)
    super(instruction, gate)
    @value = instruction.to_i
  end

  def evaluate
    @output ||= @value
  end
end
class PassThroughValue < Gate
  def initialize(instruction, grid)
    super(instruction, grid)
    @symbol = instruction
  end

  def evaluate
    @output ||= @grid[@symbol].evaluate
  end
end
class NotGate < Gate
  def initialize(instruction, grid)
    super(instruction, grid)
    @symbol = instruction.split[1]
  end

  def evaluate
    @output ||= ~(@grid[@symbol].evaluate) & 65_535
  end
end
class ORGate <Gate
  def initialize(instruction, grid)
    super(instruction, grid)
    @symbol, _, @operand = instruction.split
  end

  def evaluate
    operand1 = convert_to_int_or_evaluate(@symbol)
    operand2 = convert_to_int_or_evaluate(@operand)
    @output ||= (operand1 | operand2) & 65_535
  end
end
class ANDGate < Gate
  def initialize(instruction, grid)
    super(instruction, grid)
    @symbol, _, @operand = instruction.split
  end

  def evaluate
    operand1 = convert_to_int_or_evaluate(@symbol)
    operand2 = convert_to_int_or_evaluate(@operand)
    @output ||= (operand1 & operand2) & 65_535
  end 
end

class Circuit
  attr_reader :outputs
  def initialize
    @gates = {}
  end

  def add_group(schema)
    matches = schema.match(/(.*) -> ([a-z]+)/)
    label = matches[2]
    instruction = matches[1]
    @gates[label] = parse(instruction)
  end

  def parse(instruction)
    case instruction
    when /NOT/
      return NotGate.new(instruction, @gates)
    when /RSHIFT/
      return RshiftGate.new(instruction, @gates)
    when /LSHIFT/
      return LShiftGate.new(instruction, @gates)
    when /OR/
      return ORGate.new(instruction, @gates)
    when /AND/
      return ANDGate.new(instruction, @gates)
    when /[a-z]+/
      return PassThroughValue.new(instruction, @gates)
    when /\d+/
      return LiteralValue.new(instruction)
    end
  end

  def resolve(wire)
    throw InvalidSymbolException unless @gates.key?(wire)
    @gates[wire].evaluate
  end

  def reset
    @gates.values.each(&:reset)
  end
end
