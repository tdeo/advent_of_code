# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class TrashCompactor
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @operations = T.let(@input.lines(chomp: true).map(&:split).transpose, T::Array[T::Array[String]])
  end

  sig { returns(Integer) }
  def part1
    @operations.sum do |operation|
      values = T.must(operation[0...-1]).map(&:to_i)
      operation.last == '+' ? values.sum : values.reduce(&:*).to_i
    end
  end

  sig { returns(Integer) }
  def part2
    cols = @input.lines(chomp: true).map(&:chars).transpose
    result = 0
    buffer = T.let([], T::Array[Integer])
    cols.reverse_each do |col|
      number = col.join.tr('^0-9', '')
      buffer << number.to_i unless number.empty?
      if col.include?('*')
        result += buffer.reduce(&:*).to_i
        buffer = []
      elsif col.include?('+')
        result += buffer.sum
        buffer = []
      end
    end

    result
  end
end
