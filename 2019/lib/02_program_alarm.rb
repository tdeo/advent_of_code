# frozen_string_literal: true

require_relative 'intcode'

class ProgramAlarm
  def initialize(input)
    @input = input
    @tape = @input.split(',').map(&:to_i)
  end

  def part1(test: false)
    intcode = Intcode.new(@input)

    unless test
      intcode.set(1, 12)
      intcode.set(2, 2)
    end

    intcode.run
    intcode.get(0)
  end

  def part2(target = 19_690_720)
    (0..99).each do |i1|
      next if i1 >= @tape.length

      (0..99).each do |i2|
        next if i2 >= @tape.length

        intcode = Intcode.new(@input)
        intcode.set(1, i1)
        intcode.set(2, i2)
        intcode.run
        return 100 * i1 + i2 if intcode.get(0) == target
      end
    end
  end
end
