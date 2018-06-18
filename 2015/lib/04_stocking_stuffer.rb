require 'digest'

class StockingStuffer
  def initialize(input)
    @key = input.strip
  end

  def hash(i)
    Digest::MD5.hexdigest("#{@key}#{i}")
  end

  def part1
    i = 1
    while hash(i)[0..4] != '00000'
      i += 1
    end
    i
  end

  def part2
    i = 1
    while hash(i)[0..5] != '000000'
      i += 1
    end
    i
  end
end
