# frozen_string_literal: true

class MazeTrampolines
  def initialize(input)
    @tramps = input.split("\n").map { _1.strip.to_i }
    @size = @tramps.size
    @idx = 0
    # @tramps[@idx] = @tramps[@idx][1...-1]
    # @tramps = @tramps.map(&:to_i)
  end

  def part1
    steps = 0
    while (@idx >= 0) && (@idx < @size)
      diff = @tramps[@idx]
      @tramps[@idx] += 1
      @idx += diff
      steps += 1
    end
    steps
  end

  def part2
    steps = 0
    while (@idx >= 0) && (@idx < @size)
      diff = @tramps[@idx]
      @tramps[@idx] += (diff >= 3 ? -1 : 1)
      @idx += diff
      steps += 1
    end
    steps
  end
end
