require 'digest'

class AdventCoinGenerator
  SECRET_KEY = 'ckczppom'
  def initialize(key = SECRET_KEY)
    @key = key
    @md5 = MD5Transformer.new
  end

  def generate(filter)
    coin = 0
    loop do
      candidate = @md5.generate("#{@key}#{coin}")
      break if candidate.to_s.start_with?(filter)
      coin += 1
    end
    coin
  end
end

class MD5Transformer
  def generate(coin)
    Digest::MD5.new.update(coin)
  end
end

advent_coin = AdventCoinGenerator.new
puts advent_coin.generate('00000')
puts advent_coin.generate('000000')
