class Noise
  def initialize(input)
    @messages = input.strip.split("\n").map(&:strip)
    @size = @messages.first.size
  end

  def letter(pos)
    letters = Hash.new { |h, k| h[k] = 0 }
    @messages.each { |m| letters[m[pos]] += 1 }
    letters.max_by { |k, v| v }.first
  end

  def lesser_letter(pos)
    letters = Hash.new { |h, k| h[k] = 0 }
    @messages.each { |m| letters[m[pos]] += 1 }
    letters.min_by { |k, v| v }.first
  end

  def part1
    (0...@size).map { |i| letter(i) }.join
  end

  def part2
    (0...@size).map { |i| lesser_letter(i) }.join
  end
end
