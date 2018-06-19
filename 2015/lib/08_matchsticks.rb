class Matchsticks
  def initialize(input)
    @strings = input.split("\n").map(&:strip)
  end

  def part1
    @strings.map { |str| str.size - eval(str).size }.reduce(:+)
  end

  def part2
    @strings.map { |str| str.inspect.size - str.size }.reduce(:+)
  end
end
