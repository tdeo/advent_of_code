# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative '../../lib/iterate_with_cycle'

class ParabolicReflectorDish
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @lines = T.let(@input.lines(chomp: true), T::Array[String])
  end

  sig { void }
  def tilt_north!
    (0...T.must(@lines.first).size).each do |j|
      i = @lines.size - 1

      while i > 0
        if T.must(@lines[i])[j] == 'O' && T.must(@lines[i - 1])[j] == '.'
          T.must(@lines[i])[j], T.must(@lines[i - 1])[j] = T.must(@lines[i - 1])[j], T.must(@lines[i])[j]
          i += 1 if i < @lines.size - 1
        else
          i -= 1
        end
      end
    end
  end

  sig { void }
  def tilt_west!
    (0...@lines.size).each do |i|
      j = T.must(@lines.first).size - 1

      while j > 0
        if T.must(@lines[i])[j] == 'O' && T.must(@lines[i])[j - 1] == '.'
          T.must(@lines[i])[j], T.must(@lines[i])[j - 1] = T.must(@lines[i])[j - 1], T.must(@lines[i])[j]
          j += 1 if j < T.must(@lines.first).size - 1
        else
          j -= 1
        end
      end
    end
  end

  sig { void }
  def tilt_south!
    (0...T.must(@lines.first).size).each do |j|
      i = 0

      while i < @lines.size - 1
        if T.must(@lines[i])[j] == 'O' && T.must(@lines[i + 1])[j] == '.'
          T.must(@lines[i])[j], T.must(@lines[i + 1])[j] = T.must(@lines[i + 1])[j], T.must(@lines[i])[j]
          i -= 1 if i > 0
        else
          i += 1
        end
      end
    end
  end

  sig { void }
  def tilt_east!
    (0...@lines.size).each do |i|
      j = 0

      while j < T.must(@lines.first).size - 1
        if T.must(@lines[i])[j] == 'O' && T.must(@lines[i])[j + 1] == '.'
          T.must(@lines[i])[j], T.must(@lines[i])[j + 1] = T.must(@lines[i])[j + 1], T.must(@lines[i])[j]
          j -= 1 if j > 0
        else
          j += 1
        end
      end
    end
  end

  sig { void }
  def cycle!
    tilt_north!
    tilt_west!
    tilt_south!
    tilt_east!
  end

  sig { returns(Integer) }
  def north_weight
    @lines.each_with_index.sum do |line, i|
      line.each_char.sum do |c|
        c == 'O' ? (@lines.size - i) : 0
      end
    end
  end

  sig { returns(Integer) }
  def part1
    tilt_north!
    north_weight
  end

  sig { returns(Integer) }
  def part2
    IterateWithCycle.new(@lines.hash) do
      cycle!
      @lines.hash
    end.iterate(1_000_000_000)

    north_weight
  end
end
