require_relative 'intcode'

class SunnywithaChanceofAsteroids
  def initialize(input)
    @input = input
    @intcode = Intcode.new(@input)
  end

  def sendint(val)
    @intcode.sendint(val)
    self
  end

  def run
    @intcode.run
  end

  def part1
    sendint(1).run
    @intcode.getint
  end

  def part2
    sendint(5).run
    @intcode.getint
  end
end
