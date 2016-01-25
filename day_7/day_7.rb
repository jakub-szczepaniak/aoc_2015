class InvalidSymbolException < Exception
end

class Circuit
  def initialize
    @symbols = {}
  end

  def add_group(schema)
    matches = schema.match(/(.*) -> ([a-z]+)/)
    label = matches[2]
    instruction = matches[1]
    @symbols[label] = instruction
  end

  def resolve(wire)
    throw InvalidSymbolException unless @symbols.key?(wire)
    p wire
    if not_operation(wire)
      operand1 = resolve(@symbols[wire].split[1]) 
      return (~operand1) & 65_535
    elsif rshift(wire)
      operand1 = resolve(@symbols[wire].split[0])
      operand2 = @symbols[wire].split[2].to_i
      return (operand1 >> operand2) & 65_535
    elsif lshift(wire)
      operand1 = resolve(@symbols[wire].split[0])
      operand2 = @symbols[wire].split[2].to_i
      return (operand1 << operand2) & 65_535
    elsif or_gate(wire)
      operand1 = resolve(@symbols[wire].split[0])
      operand2 = resolve(@symbols[wire].split[2])
      return (operand1 | operand2) & 65_535
    elsif and_gate(wire)
      operand1 = resolve(@symbols[wire].split[0])
      operand2 = resolve(@symbols[wire].split[2])
      return (operand1 & operand2) & 65_535
    elsif numeric(wire)
      return @symbols[wire].to_i
    else
      resolve(@symbols[wire])
    end
  end

  def numeric(wire)
    @symbols[wire] =~ /\d+/
  end

  def not_operation(wire)
    @symbols[wire] =~ /NOT/
  end

  def rshift(wire)
    @symbols[wire] =~ /RSHIFT/
  end

  def lshift(wire)
    @symbols[wire] =~ /LSHIFT/
  end

  def or_gate(wire)
    @symbols[wire] =~ /OR/
  end

  def and_gate(wire)
    @symbols[wire] =~ /AND/
  end
end
