class PasswordGenerator
  def initialize(old_password)
    fail StandardError unless old_password.length == 8
    @password = old_password
  end
end
