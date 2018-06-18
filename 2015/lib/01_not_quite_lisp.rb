class NotQuiteLisp
  def initialize(input)
    @input = input
  end

  def part1
    floor = 0
    @input.each_char do |c|
      floor -= 1 if c == ')'
      floor += 1 if c == '('
    end
    floor
  end

  def part2
    floor = 0
    @input.each_char.each_with_index do |c, i|
      floor -= 1 if c == ')'
      floor += 1 if c == '('
      return i + 1 if floor < 0
    end
    nil
  end
end
