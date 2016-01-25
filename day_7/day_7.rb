class InvalidSymbolException < Exception
end

class Circuit
  attr_reader :outputs
  def initialize
    @symbols = {}
    @outputs = {}
  end

  def add_group(schema)
    matches = schema.match(/(.*) -> ([a-z]+)/)
    label = matches[2]
    instruction = matches[1]
    @symbols[label] = instruction
  end

  def resolve(wire)
    throw InvalidSymbolException unless @symbols.key?(wire)
    return @outputs[wire] if @outputs.key?(wire)
    if not_operation(@symbols[wire])
      operand1 = resolve(@symbols[wire].split[1])
      return @outputs[wire] = (~operand1) & 65_535
    elsif rshift(wire)
      operand1 = resolve(@symbols[wire].split[0])
      operand2 = @symbols[wire].split[2].to_i
      return @outputs[wire] = (operand1 >> operand2) & 65_535
    elsif lshift(wire)
      operand1 = resolve(@symbols[wire].split[0])
      operand2 = @symbols[wire].split[2].to_i
      return @outputs[wire] = (operand1 << operand2) & 65_535
    elsif or_gate(@symbols[wire])
      if numeric(@symbols[wire].split[0])
        operand1 = @symbols[wire].split[0].to_i
      else
        operand1 = resolve(@symbols[wire].split[0])
      end
      if numeric(@symbols[wire].split[2])
        operand2 = @symbols[wire].split[2].to_i
      else
        operand2 = resolve(@symbols[wire].split[2])
      end
      @outputs[wire] = (operand1 | operand2) & 65_535
      return @outputs[wire]
    elsif and_gate(@symbols[wire])
      if numeric(@symbols[wire].split[0])
        operand1 = @symbols[wire].split[0].to_i
      else
        operand1 = resolve(@symbols[wire].split[0])
      end
      if numeric(@symbols[wire].split[2])
        operand2 = @symbols[wire].split[2].to_i
      else
        operand2 = resolve(@symbols[wire].split[2])
      end
      return @outputs[wire] = (operand1 & operand2) & 65_535
    elsif numeric(@symbols[wire])
      return @outputs[wire] = @symbols[wire].to_i
    else
      return @outputs[wire] = resolve(@symbols[wire])
    end
  end

  def numeric(wire)
    wire =~ /\d+/
  end

  def not_operation(wire)
    wire =~ /NOT/
  end

  def rshift(wire)
    @symbols[wire] =~ /RSHIFT/
  end

  def lshift(wire)
    @symbols[wire] =~ /LSHIFT/
  end

  def or_gate(wire)
    wire =~ /OR/
  end

  def and_gate(wire)
    wire =~ /AND/
  end
end
