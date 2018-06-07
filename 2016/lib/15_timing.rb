class Timing
  def initialize(input)
  end

  def valid?(time)
    @wheels.all? do |idx, wheel|
      (time + idx + wheel[1]) % wheel[0] == 0
    end
  end

  def run!
    i = 0
    while !valid?(i)
      i += 1
    end
    i
  end

  def demo
    @wheels = {
      1 => [5, 4],
      2 => [2, 1],
    }
  run!
  end

  def part1
    @wheels = {
      1 => [17, 5],
      2 => [19, 8],
      3 => [7, 1],
      4 => [13, 7],
      5 => [5, 1],
      6 => [3, 0],
    }
    run!
  end

  def part2
    @wheels = {
      1 => [17, 5],
      2 => [19, 8],
      3 => [7, 1],
      4 => [13, 7],
      5 => [5, 1],
      6 => [3, 0],
      7 => [11, 0],
    }
    run!
  end
end
