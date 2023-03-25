class Light
  def initialize
    @state = false
  end

  def on
    @state = true
  end

  def off
    @state = false
  end

  def toggle
    @state = !@state
  end

  def on?
    @state
  end
end

class RegulatedLight
  def initialize
    @brightness = 0
  end

  def on
    @brightness += 1
  end

  def brightness
    @brightness
  end

  def toggle
    on
    on
  end

  def off
    @brightness = [0, @brightness - 1].max
  end
end
class LightingGrid
  def initialize(light = Light)
    @lights = Array.new(1000) {
      Array.new(1000) {
        light.new
      }
    }
  end

  def lit
    @lights.flatten.count(&:on?)
  end

  def process(instruction)
    instruction.top_x.upto(instruction.bottom_x) do |row|
      instruction.top_y.upto(instruction.bottom_y) do |column|
        @lights[row][column].send(instruction.action)
      end
    end
  end
end
class RegulatedLightningGrid < LightingGrid
  def initialize(light = RegulatedLight)
    super(light)
  end

  def lit
    @lights.flatten.count { | light | light.brightness > 0 }
  end

  def brightness
    total_brightness = 0
    @lights.flatten.each { |light| total_brightness += light.brightness }
    total_brightness
  end
end

Instruction = Struct.new(:top_x, :top_y, :bottom_x, :bottom_y, :action)

class InstructionParser
  def parse(line)
    input = line.match(/([a-z]+) (\d*),(\d*) through (\d*),(\d*)/)
    Instruction.new(
      input[2].to_i,
      input[3].to_i,
      input[4].to_i,
      input[5].to_i,
      input[1].to_sym)
  end
end
