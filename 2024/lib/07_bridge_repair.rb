# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class BridgeRepair
  extend T::Sig

  class Problem
    extend T::Sig

    sig { returns(Integer) }
    attr_reader :target

    sig { params(line: String).void }
    def initialize(line)
      target, values = line.split(': ')
      @target = T.let(target.to_i, Integer)
      @values = T.let(T.must(values).split.map(&:to_i), T::Array[Integer])
      @concatenation = T.let(false, T::Boolean)
    end

    sig { void }
    def enable_concatenatenation!
      @concatenation = true
    end

    sig { params(target: Integer, values: T::Array[Integer], size: Integer).returns(T::Boolean) }
    def valid?(target = @target, values = @values, size = values.size)
      return target == 0 if size == 0

      val = T.must(values[size - 1])
      if @concatenation && target.to_s.end_with?(val.to_s) &&
         valid?(target.to_s.delete_suffix(val.to_s).to_i, values, size - 1)
        return true
      end

      return true if target % val == 0 && valid?(target / val, values, size - 1)

      valid?(target - val, values, size - 1)
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @problems = T.let(@input.each_line(chomp: true).map { Problem.new(_1) }, T::Array[Problem])
  end

  sig { returns(Integer) }
  def part1
    @problems.filter(&:valid?).sum(&:target)
  end

  sig { returns(Integer) }
  def part2
    @problems.each(&:enable_concatenatenation!).filter(&:valid?).sum(&:target)
  end
end
