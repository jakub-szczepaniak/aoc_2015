class SequenceCalculator
  def initialize(initial_sequence)
    fail(StandardError) if valid?(initial_sequence)
  end

  private

  def valid?(sequence)
    sequence == '' || sequence =~ /[\D]/
  end
end
