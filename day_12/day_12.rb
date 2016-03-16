require 'json'
class JSONCalc
  def initialize(document)
    @json = JSON.parse(document)
  end

  def sum
    if @json == {} || @json == []
      0
    else
      @json.inject(&:+)
    end
  end
end
