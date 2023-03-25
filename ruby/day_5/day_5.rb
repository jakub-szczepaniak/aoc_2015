class ThreeVowels
  def valid?(candidate)
    vowel_count(candidate) > 2
  end

  private

  def vowel_count(candidate)
    candidate.chars.count { |char| vowel?(char) }
  end

  def vowel?(character)
    %w(a e o i u ).include?(character)
  end
end

class ConsecutiveLetters
  def valid?(candidate)
    candidate.chars.each_cons(2).any? { |a, b| a == b }
  end
end

class NoNastySequence
  def valid?(candidate)
    if candidate.match(/ab|cd|pq|xy/)
      false
    else
      true
    end
  end
end

class PairOfLetters
  def valid?(candidate)
    candidate.match(/([a-zA-Z]{2,}).*\1/) != nil
  end
end

class DoubleWithBetween
  def valid?(candidate)
    candidate.chars.each_cons(3).any? { |a, _, c| a == c }
  end
end
