# frozen_string_literal: true

require_relative 'intcode'

class SensorBoost
  def initialize(input)
    @input = input
  end

  def part1
    intcode = Intcode.new(@input).sendint(1)
    intcode.run_until_input
    intcode.stdout[0]
  end

  def part2
    intcode = Intcode.new(@input).sendint(2)
    intcode.run_until_input
    intcode.stdout[0]
  end
end
