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
    @gates[label] = instruction
  end
  def evaluate_not(operand)
    (~operand) & 65_535
  end

  def evaluate_rshift(operand1, operand2)
    (operand1 >> operand2) & 65_535
  end

  def evaluate_lshift(operand1, operand2)
    (operand1 << operand2) & 65_535
  end

  def evaluate_or(operand1, operand2)
    (operand1 | operand2) & 65_535
  end

  def evaluate_and(operand1, operand2)
    (operand1 & operand2) & 65_535
  end

  def resolve(wire)
    throw InvalidSymbolException unless @gates.key?(wire)
    return @outputs[wire] if @outputs.key?(wire)
    case @gates[wire]
    when /NOT/
      operand = resolve(@gates[wire].split[1])
      return @outputs[wire] = evaluate_not(operand)
    when /RSHIFT/
      operand1 = resolve(@gates[wire].split[0])
      operand2 = @gates[wire].split[2].to_i
      return @outputs[wire] = evaluate_rshift(operand1, operand2)
    when /LSHIFT/
      operand1 = resolve(@gates[wire].split[0])
      operand2 = @gates[wire].split[2].to_i
      return @outputs[wire] = evaluate_lshift(operand1, operand2)
    when /OR/
      if numeric(@gates[wire].split[0])
        operand1 = @gates[wire].split[0].to_i
      else
        operand1 = resolve(@gates[wire].split[0])
      end
      if numeric(@gates[wire].split[2])
        operand2 = @gates[wire].split[2].to_i
      else
        operand2 = resolve(@gates[wire].split[2])
      end
      @outputs[wire] = evaluate_or(operand1, operand2)
      return @outputs[wire]
    when /AND/
      if numeric(@gates[wire].split[0])
        operand1 = @gates[wire].split[0].to_i
      else
        operand1 = resolve(@gates[wire].split[0])
      end
      if numeric(@gates[wire].split[2])
        operand2 = @gates[wire].split[2].to_i
      else
        operand2 = resolve(@gates[wire].split[2])
      end
      return @outputs[wire] = evaluate_and(operand1, operand2)
    when /\d+/
      return @outputs[wire] = @gates[wire].to_i
    end
    @outputs[wire] = resolve(@gates[wire])
  end

  def numeric(wire)
    wire =~ /\d+/
  end
end
