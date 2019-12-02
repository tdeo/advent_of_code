class TheTyrannyoftheRocketEquation
  def initialize(input)
    @input = input.each_line.map(&:to_i)
  end

  def part1
    s = 0
    @input.each do |i|
      s += (i / 3) - 2
    end
    s
  end

  def part2
    s = 0
    @input.each do |i|
      i = i / 3 - 2
      while i > 0 do
        s += i
        i = i / 3 - 2
      end
    end
    s
  end
end
