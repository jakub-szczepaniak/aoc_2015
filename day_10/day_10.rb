class SequenceCalculator
  def initialize(initial_sequence)
    fail(StandardError) if valid?(initial_sequence)
    @sequence = initial_sequence.chars.map(&:to_i)
  end

  def calculate
    prev = @sequence[0]
    @sequence.slice_before {|e|
      prev, prev2 = e, prev
      prev2 != e}.flat_map{ |numbers| [numbers.count, numbers.first]}.join('')
  end

  private

  def valid?(sequence)
    sequence == '' || sequence =~ /[\D]/
  end
end
