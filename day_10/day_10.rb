class SequenceCalculator
  def initialize(initial_sequence)
    fail(StandardError) if invalid?(initial_sequence)
    @sequence = initial_sequence.chars.map(&:to_i)
  end

  def calculate(iterations = 1)
    iterations.times do
      prev = @sequence[0]
      @sequence = @sequence.slice_before { |e|
        prev, prev2 = e, prev
        prev2 != e }.flat_map { |numbers| [numbers.count, numbers.first]}
    end
    @sequence.join('')
  end

  def length
    @sequence.count
  end

  private

  def invalid?(sequence)
    sequence == '' || sequence =~ /[\D]/
  end
end
