# frozen_string_literal: true

class ChocolateCharts
  def initialize(input)
    @input = input.strip
    @recipes = @input.to_i
    @code = @input.chars.map(&:to_i)
    @scores = [3, 7]
    @a = 0
    @b = 1
  end

  def round!
    sum = @scores[@a] + @scores[@b]
    @scores << 1 if sum > 9
    @scores << (sum % 10)
    @a = (1 + @scores[@a] + @a) % @scores.size
    @b = (1 + @scores[@b] + @b) % @scores.size
  end

  def part1
    round! while @scores.size < 10 + @recipes
    @scores[@recipes...(@recipes + 10)].join
  end

  def part2
    step = 0
    loop do
      300_000.times { round! }
      (step...(@scores.size - @code.size)).each do |i|
        return i if @code.each_with_index.all? { |c, j| c == @scores[i + j] }
      end
      step = @scores.size - @code.size
      print '.'
    end
    @scores.size - @code.size - code?
  end
end
