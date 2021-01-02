# frozen_string_literal: true

class Generators
  def initialize(input)
    @a, @b = input.each_line.map { |l| l.gsub(/^.*\s(\d+)$/, '\1').to_i }
    @a_mult = 16_807
    @b_mult = 48_271
    @mod = 2_147_483_647
    @comp = 2**16
    @count = 40_000_000
    @identical = 0
  end

  def compute_next!
    @a = (@a * @a_mult) % @mod
    @b = (@b * @b_mult) % @mod
    @identical += 1 if (@a - @b) % @comp == 0
  end

  def part1
    @count.times do
      compute_next!
    end
    @identical
  end

  def compute_next2!
    loop do
      @a = (@a * @a_mult) % @mod
      break if @a % 4 == 0
    end
    loop do
      @b = (@b * @b_mult) % @mod
      break if @b % 8 == 0
    end
    @identical += 1 if (@a - @b) % @comp == 0
  end

  def part2
    @count = 5_000_000
    @count.times do
      compute_next2!
    end
    @identical
  end
end
