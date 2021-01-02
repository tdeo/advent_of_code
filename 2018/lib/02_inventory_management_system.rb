# frozen_string_literal: true

class InventoryManagementSystem
  def initialize(input)
    @input = input
  end

  def double?(word)
    word.chars.group_by(&:itself).any? { |_, v| v.size == 2 }
  end

  def triple?(word)
    word.chars.group_by(&:itself).any? { |_, v| v.size == 3 }
  end

  def part1
    d = 0
    t = 0
    @input.each_line do |w|
      d += 1 if double?(w)
      t += 1 if triple?(w)
    end
    d * t
  end

  def wildcards(word)
    (0...word.size).each do |i|
      w = word.dup
      w[i] = '.'
      yield w
    end
  end

  def part2
    viewed = {}
    @input.split.each do |w|
      wildcards(w) do |w2|
        return w2.tr('.', '') if viewed[w2]

        viewed[w2] = true
      end
    end
  end
end
