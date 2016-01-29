class InvalidSymbolException < Exception
end

class Circuit
  attr_reader :outputs
  def initialize
    @gates = {}
    @outputs = {}
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
      return NotInstruction.new(instruction, @gates)
    when /RSHIFT/
      return RshiftInstruction.new(instruction, @gates)
    when /LSHIFT/
      return LShiftInstruction.new(instruction, @gates)
    when /OR/
      return ORInstruction.new(instruction, @gates)
    when /AND/
      return ANDInstruction.new(instruction, @gates)
    when /[a-z]+/
      return PassThroughValue.new(instruction, @gates)
    when /\d+/
      return LiteralValue.new(instruction)
    end
    instruction
  end
  class ANDInstruction
    def initialize(instruction, grid)
      @symbol, _, @operand = instruction.split
      @grid = grid
    end

    def evaluate
      if @symbol =~ /\d+/
        operand1 = @symbol.to_i
      else
        operand1 = @grid[@symbol].evaluate
      end
      if @operand =~ /\d+/
        operand2 = @operand.to_i
      else
        operand2 = @grid[@operand].evaluate
      end
      (operand1 & operand2) & 65_535
    end 
  end
  
  class ORInstruction
    def initialize(instruction, grid)
      @symbol, _, @operand = instruction.split
      @grid = grid
    end

    def evaluate
      if @symbol =~ /\d+/
        operand1 = @symbol.to_i
      else
        operand1 = @grid[@symbol].evaluate
      end
      if @operand =~ /\d+/
        operand2 = @operand.to_i
      else
        operand2 = @grid[@operand].evaluate
      end
      (operand1 | operand2) & 65_535
    end
  end
  class LShiftInstruction
    def initialize(instruction, grid)
      @symbol, _, @operand = instruction.split
      @grid = grid
    end

    def evaluate
      (@grid[@symbol].evaluate << @operand.to_i) & 65_535
    end
  end
  class RshiftInstruction
    def initialize(instruction, grid)
      @symbol, _, @operand = instruction.split
      @grid = grid
    end

    def evaluate
      (@grid[@symbol].evaluate >> @operand.to_i) & 65_535
    end
  end
  class LiteralValue
    def initialize(instruction)
      @value = instruction.to_i
    end

    def evaluate
      @value
    end
  end
  class PassThroughValue
    def initialize(instruction, grid)
      @symbol = instruction
      @grid = grid
    end

    def evaluate
      @grid[@symbol].evaluate
    end
  end
  class NotInstruction
    def initialize(instruction, grid)
      @symbol = instruction.split[1]
      @grid = grid
    end

    def evaluate
      ~(@grid[@symbol].evaluate) & 65_535
    end
  end

  def resolve(wire)
    throw InvalidSymbolException unless @gates.key?(wire)
    return @outputs[wire] if @outputs.key?(wire)
    @outputs[wire] = @gates[wire].evaluate
  end
end
