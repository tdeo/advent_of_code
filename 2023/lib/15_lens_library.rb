# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class LensLibrary
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = T.let(input.chomp, String)
    @h = T.let(0, Integer)
  end

  sig { params(str: String).returns(Integer) }
  def hash(str)
    h = 0
    str.each_char { h = ((h + _1.ord) * 17) % 256 }
    h
  end

  sig { returns(Integer) }
  def part1
    @input.split(',').sum { hash(_1) }
  end

  sig { returns(Integer) }
  def part2
    boxes = T.let(Hash.new { |h, k| h[k] = {} }, T::Hash[Integer, T::Hash[String, Integer]])
    @input.split(',').each do |instruction|
      label = T.must(instruction[/\w+/])
      box = hash(label)
      op = instruction[/[\-=]/]
      if op == '-'
        boxes[box]&.delete(label)
      elsif op == '='
        (boxes[box] ||= {})[label] = instruction[-1].to_i
      end
    end
    boxes.sum do |box_number, lenses|
      (box_number + 1) * lenses.each_value.with_index.sum do |focal, i|
        (i + 1) * focal
      end
    end
  end
end
