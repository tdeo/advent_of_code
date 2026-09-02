# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class GrovePositioningSystem
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @list = T.let(input.lines(chomp: true).each_with_index.map { |v, i| [v.to_i, i] }, T::Array[[Integer, Integer]])
    @original = T.let(@list.dup, T::Array[[Integer, Integer]])
  end

  sig { void }
  def mix!
    @original.each do |number, key|
      next if number == 0

      index = T.must(@list.find_index { _1[1] == key })
      item = T.must(@list.delete_at(index))
      insert_at = (index + number) % @list.size
      insert_at = -1 if insert_at == 0
      @list.insert(insert_at, item)
    end
  end

  sig { returns(Integer) }
  def grove_coordinates
    idx = T.must(@list.find_index { _1[0] == 0 })
    [1000, 2000, 3000].sum do |offset|
      T.must(@list[(idx + offset) % @list.size])[0]
    end
  end

  sig { returns(Integer) }
  def part1
    mix!
    grove_coordinates
  end

  sig { returns(Integer) }
  def part2
    @list.each { _1[0] *= 811_589_153 }
    @original = @list.dup

    10.times { mix! }
    grove_coordinates
  end
end
