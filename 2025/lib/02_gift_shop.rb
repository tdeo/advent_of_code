# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class GiftShop
  extend T::Sig

  class Range
    extend T::Sig

    sig { returns(Integer) }
    attr_reader :min, :max

    sig { params(input: String).void }
    def initialize(input)
      @input = input
      min, max = input.split('-').map(&:to_i)
      @min = T.let(min.to_i, Integer)
      @max = T.let(max.to_i, Integer)
    end

    sig { params(repeats: Integer).returns(T::Array[Integer]) }
    def invalid_ids(repeats = 2)
      begin_at = @min.to_s[0...(@min.to_s.size / repeats)].to_i
      finish_at = @max.to_s[0...(@max.to_s.size / repeats)].to_i
      finish_at = begin_at.to_s.tr('0-9', '9').to_i if finish_at < begin_at

      result = []
      (begin_at..finish_at).each do |i|
        value = (i.to_s * repeats).to_i
        break if value > @max
        next if value < @min

        result << value
      end
      result
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @ranges = T.let(input.split(',').map { Range.new(_1.strip) }, T::Array[Range])
  end

  sig { returns(Integer) }
  def part1
    result = 0
    @ranges.each { result += _1.invalid_ids.sum }
    result
  end

  sig { returns(Integer) }
  def part2
    @ranges.sum do |range|
      invalid_ids = T.let([], T::Array[Integer])
      (2..range.max.to_s.size).each do |size|
        invalid_ids |= range.invalid_ids(size)
      end
      invalid_ids.sum
    end
  end
end
