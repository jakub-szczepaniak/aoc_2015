class InvalidSymbolException < Exception
end
class Circuit
  def initialize
    @symbols = {}
  end

  def add_group(schema)
    matches = schema.match(/(.*) -> ([a-z]+)/)
    @symbols[matches[2]] = matches[1]
  end

  def resolve(wire)
    throw InvalidSymbolException unless @symbols.key?(wire)
  
    if not_operation(wire)
      return (~resolve(@symbols[wire].split[1])) & 65_535
    elsif rshift(wire)
      argument = resolve(@symbols[wire].split[0])
      value = @symbols[wire].split[2].to_i
      return (argument >> value) & 65_535
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
end
