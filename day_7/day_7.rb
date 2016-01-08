class Circuit
  def initialize
    @wires = {}
  end

  def add_wire(schema)
    matches = schema.match(/(\d*) -> ([a-z]+)/)
    @wires[matches[2].to_sym] = matches[1].to_i
  end

  def resolve(wire)
    @wires[wire.to_sym]
  end
end
