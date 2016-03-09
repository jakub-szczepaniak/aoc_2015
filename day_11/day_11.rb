class PasswordGenerator
  def initialize(old_password)
    fail StandardError unless old_password.length == 8
    @password = old_password
  end
end

class PasswordValidator

  def valid?(password)
    increased?(password) && double_letter?(password) && no_confusing?(password)
  end

  def increased?(password)
    password.chars.each_cons(3).any? do |first, second, third|
      first.ord + 1 == second.ord && first.ord + 2 == third.ord
    end
  end

  def double_letter?(password)
    password.scan(/(.)\1/).count >= 2
  end

  def no_confusing?(password)
    password.scan(/[iol]/).empty?
  end

end