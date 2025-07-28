# frozen_string_literal: true

class ComboBreaker
  MOD = 20_201_227
  SUBJECT = 7

  def initialize(input)
    @input = input
    @door, @card = input.split("\n").map(&:to_i)
  end

  def res(value, pow)
    r = 1
    pow.times do
      r = (r * value) % MOD
    end
    r
  end

  def part1
    powers = {}

    exp = 0
    val = 1

    loop do
      break if powers.key?(@door) && powers.key?(@card)

      powers[val] = exp
      val = (val * SUBJECT) % MOD
      exp += 1
    end

    door = res(@door, powers[@card])
    card = res(@card, powers[@door])
    raise if door != card

    door
  end

  def part2
    0
  end
end
