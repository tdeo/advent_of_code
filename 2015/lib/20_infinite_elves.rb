# frozen_string_literal: true

require 'prime'

class InfiniteElves
  def initialize(input)
    @target = input.strip.to_i
  end

  def divisor_sum(n)
    divs = n.prime_division.map { |p, pow| ((p**(pow + 1)) - 1) / (p - 1) }
    divs.empty? ? 1 + n : divs.reduce(:*)
  end

  def part1
    k = 1
    k += 1 while divisor_sum(k) * 10 < @target
    k
  end

  def presents_part2(n)
    i = 1
    sum = 0
    while i**2 < n && i <= 50
      if n % i == 0
        sum += n / i
        sum += i if n / i <= 50
      end
      i += 1
    end
    sum += i if i**2 == n && i <= 50
    sum * 11
  end

  def part2
    k = 1
    k += 1 while presents_part2(k) < @target
    k
  end
end
