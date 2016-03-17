require 'json'
class JSONCalc
  def initialize(document)
    @json = JSON.parse(document)
  end

  def sum
    if @json == {} || @json == []
      0
    elsif @json.class == Array
      @json.flatten.inject(&:+)
    elsif @json.class == Hash
      @json.values.flatten.inject(&:+)
    end
  end
end
