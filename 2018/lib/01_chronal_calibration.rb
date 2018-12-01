class ChronalCalibration
  def initialize(input)
    @input = input
  end

  def part1
    @input.split("\n").map(&:to_i).sum
  end

  def part2
    viewed = {}
    current = 0
    @input.each_line.cycle do |l|
      return current if viewed[current]
      viewed[current] = true
      current += l.to_i
    end
  end
end
