# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class Factory
  extend T::Sig

  class Machine
    extend T::Sig

    sig { params(input: String).void }
    def initialize(input)
      @input = input
      target, *buttons, joltages = input.split
      @target = T.let(T.must(target.to_s[1...-1]).tr('.#', '01').reverse.to_i(2), Integer)
      @buttons = T.let(buttons.map do |b|
        T.must(b.to_s[1...-1]).split(',').map(&:to_i)
      end, T::Array[T::Array[Integer]],)
      @button_vals = T.let(buttons.map do |b|
        values = T.must(b.to_s[1...-1]).split(',').map(&:to_i)
        val = 0
        values.each { val ^= (1 << _1) }
        val
      end, T::Array[Integer],)

      @joltages = T.let(T.must(joltages.to_s[1...-1]).split(',').map(&:to_i), T::Array[Integer])
    end

    sig { returns(Integer) }
    def min_moves
      (1..@button_vals.size).each do |i|
        @button_vals.combination(i).each do |combo|
          value = combo.reduce(0, &:^)

          return i if value == @target
        end
      end
      raise
    end

    sig { returns(Integer) }
    def min_for_joltage
      print '.'
      initial = @joltages.map { 0 }
      states = T.let({ initial => 0 }, T::Hash[T::Array[Integer], Integer])
      q = T.let([initial], T::Array[T::Array[Integer]])
      while (current = q.shift)
        @buttons.each do |button|
          next_state = current.dup
          count = T.must(states[current])
          return count if next_state == @joltages
          next if next_state.each_with_index.any? { |val, index| val > T.must(@joltages[index]) }

          button.each { next_state[_1] = T.must(next_state[_1]) + 1 }

          unless states.key?(next_state)
            states[next_state] = count + 1
            q << next_state
          end
        end
      end
      raise
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @machines = T.let(input.lines(chomp: true).map { Machine.new(_1) }, T::Array[Machine])
  end

  sig { returns(Integer) }
  def part1
    @machines.sum(&:min_moves)
  end

  sig { returns(Integer) }
  def part2
    @machines.sum(&:min_for_joltage)
  end
end
