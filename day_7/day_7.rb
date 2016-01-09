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
    if numeric(wire)
      return @symbols[wire].to_i
    else
      resolve(@symbols[wire])
    end
  end

  def numeric(wire)
    @symbols[wire] =~ /\d+/
  end
end
