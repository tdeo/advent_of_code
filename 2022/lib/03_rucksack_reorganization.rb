# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class RucksackReorganization
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @rucksacks = T.let(@input.split("\n"), T::Array[String])
  end

  sig { params(char: String).returns(Integer) }
  def priority(char)
    case char
    when 'a'..'z' then 1 + char.ord - 'a'.ord
    when 'A'..'Z' then 27 + char.ord - 'A'.ord
    else throw ArgumentError
    end
  end

  sig { params(a: String, b: String).returns(String) }
  def common_char(a, b)
    chars = Set.new
    a.each_char { chars << _1 }
    b.each_char do |c|
      return c if chars.include? c
    end
    throw ArgumentError
  end

  sig { returns(Integer) }
  def part1
    @rucksacks.sum do |rucksack|
      a = rucksack[0...(rucksack.size / 2)]
      b = rucksack[(-rucksack.size / 2)..]
      priority(common_char(T.must(a), T.must(b)))
    end
  end

  sig { params(a: String, b: String, c: String).returns(String) }
  def common_char3(a, b, c)
    chars = T.let({}, T::Hash[String, Integer])
    [a, b, c].each do |string|
      viewed = Set.new
      string.each_char do |char|
        next if viewed.include?(char)

        viewed << char
        chars[char] = (chars[char] || 0) + 1
      end
    end
    T.must(chars.find { |_k, v| v == 3 }).first
  end

  sig { returns(Integer) }
  def part2
    @rucksacks.each_slice(3).sum do |a, b, c|
      priority(common_char3(T.must(a), T.must(b), T.must(c)))
    end
  end
end
