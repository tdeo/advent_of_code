# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class HauntedWasteland
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @nodes = T.let({}, T::Hash[String, [String, String]])
    @instructions = T.let(T.must(@input.lines[0]).chomp.chars, T::Array[String])

    @input.each_line(chomp: true).drop(2).each do |line|
      node, dest = line.split(' = ')
      left, right = T.must(dest).delete_prefix('(').delete_suffix(')').split(', ')
      @nodes[T.must(node)] = [T.must(left), T.must(right)]
    end
  end

  sig { returns(Integer) }
  def part1
    i = 0
    node = 'AAA'
    @instructions.cycle do |instruction|
      return i if node == 'ZZZ'

      i += 1
      node = instruction == 'R' ? T.must(@nodes[node])[1] : T.must(@nodes[node])[0]
    end
    0
  end

  sig { params(start: String).returns([Integer, Integer]) }
  def cycle_size(start)
    node = start
    first_view = T.let({}, T::Hash[String, Integer])

    i = 0
    @instructions.cycle do |instruction|
      if node.end_with?('Z')
        a = first_view[node]
        return [a, i - a] if a

        first_view[node] ||= i
      end
      i += 1

      node = instruction == 'R' ? T.must(@nodes[node])[1] : T.must(@nodes[node])[0]
    end
    [0, 0]
  end

  sig { returns(Integer) }
  def part2
    nodes = @nodes.keys.select { _1.end_with?('A') }
    cycles = nodes.map { cycle_size(_1).first }
    res = 1
    cycles.each { res = res.lcm(_1) }
    res
  end
end
