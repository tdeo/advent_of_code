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

      @outcomes = T.let({}, T::Hash[Integer, T::Array[Integer]])
      @outcomes[0] = @joltages.map { 0 }

      @moves_for_parity = T.let({}, T::Hash[Integer, T::Array[Integer]])
      @moves_for_parity[0] = [0]

      @min_moves_for = T.let({}, T::Hash[T::Array[Integer], Integer])
      @min_moves_for[@joltages.map { 0 }] = 0
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

    sig { void }
    def prepare!
      return if @outcomes.size > 1

      (1..@buttons.size).each do |i|
        @buttons.each_with_index.to_a.combination(i).each do |combo|
          outcome = @joltages.map { 0 }
          buttons = 0
          parity = 0
          combo.each do |button, index|
            parity ^= T.must(@button_vals[index])
            buttons ^= (1 << index)
            button.each { outcome[_1] = T.must(outcome[_1]) + 1 }
          end

          # require 'byebug'
          # debugger

          @outcomes[buttons] = outcome
          @moves_for_parity[parity] ||= []
          T.must(@moves_for_parity[parity]) << buttons
        end
      end
    end

    sig { params(target: T::Array[Integer]).returns(Integer) }
    def min_moves_for(target = @joltages)
      prepare!

      @min_moves_for[target] ||= begin
        parity = target.map { _1 % 2 }.reverse.join.to_i(2)
        @moves_for_parity[parity]&.filter_map do |first_move|
          remaining = target.dup
          invalid = T.let(false, T::Boolean)
          T.must(@outcomes[first_move]).each_with_index do |count, index|
            remaining[index] = T.must(remaining[index]) - count
            break invalid = true if remaining[index].to_i < 0
          end
          next if invalid

          first_move_count = first_move.to_s(2).count('1')

          remaining.map! { _1 / 2 }
          (2 * min_moves_for(remaining)) + first_move_count
        end&.min || 1_000_000
      end
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
    @machines.sum(&:min_moves_for)
  end
end
