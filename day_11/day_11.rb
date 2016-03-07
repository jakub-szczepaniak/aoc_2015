class PasswordGenerator
  def initialize(old_password)
    fail StandardError unless old_password.length == 8
    @password = old_password
  end
end

class PasswordValidator
  def increased?(password)
    password.chars.each_cons(3).any? do |a, b, c|
      a.ord + 1 == b.ord && a.ord + 2 == c.ord
    end
  end
end