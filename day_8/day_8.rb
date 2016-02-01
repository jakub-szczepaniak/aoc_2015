class Representation
  def initialize(source)
    @source = source
  end

  def code
    @source.length
  end

  def characters
    eval(@source).length
  end
  
end
