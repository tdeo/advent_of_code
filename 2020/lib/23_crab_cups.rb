# frozen_string_literal: true

class CrabCups
  def initialize(input)
    @input = input.strip
    @succ = Array.new(@input.size + 1) { nil }
    (@input + @input[0]).chars.each_cons(2) { |a, b| @succ[a.to_i] = b.to_i }
    @size = @input.size
    @current = @input[0].to_i
  end

  def move!
    a = @succ[@current]
    b = @succ[a]
    c = @succ[b]

    @succ[@current] = @succ[c]

    target = @current - 1
    target += @size if target < 1
    loop do
      break if a != target && b != target && c != target

      target -= 1
      target += @size if target < 1
    end
    @succ[c] = @succ[target]
    @succ[target] = a
    @current = @succ[@current]
  end

  def part1(moves: 100)
    moves.times { move! }
    r = [@succ[1]]
    r << @succ[r[-1]] while r[-1] != 1
    r[0...-1].join
  end

  def part2(moves: 10_000_000)
    @succ = @succ + (@size + 2..1_000_000).to_a + [@input[0].to_i]
    @succ[@input[-1].to_i] = @size + 1

    @size = @succ.size - 1
    moves.times { move! }
    @succ[1] * @succ[@succ[1]]
  end
end
