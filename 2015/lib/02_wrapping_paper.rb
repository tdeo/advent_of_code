# frozen_string_literal: true

class WrappingPaper
  def initialize(input)
    @gifts = input.split("\n").map do |l|
      next unless l =~ /^(\d+)x(\d+)x(\d+)$/

      [$1, $2, $3].map(&:to_i).sort
    end
  end

  def paper(gift)
    gift.sort!
    (3 * gift[0] * gift[1]) + (2 * gift[1] * gift[2]) + (2 * gift[0] * gift[2])
  end

  def ribbon(gift)
    gift.sort!
    (2 * (gift[0] + gift[1])) + gift.reduce(:*)
  end

  def part1
    @gifts.sum { |g| paper(g) }
  end

  def part2
    @gifts.sum { |g| ribbon(g) }
  end
end
