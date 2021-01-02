# frozen_string_literal: true

require 'digest'

class Chess
  def initialize(input)
    @input = input.strip
    @index = 0
  end

  def digest
    Digest::MD5.hexdigest(@input + @index.to_s)
  end

  def next_index!
    @index += 1 while digest[0...5] != '00000'
  end

  def next_digit!
    next_index!
    char = digest[5]
    @index += 1
    char
  end

  def part1(times = 8)
    Array.new(times) { next_digit! }.join
  end

  def part2(times = 8)
    password = {}
    while password.size < times
      next_index!
      dig = digest
      pos = dig[5].to_i(16)
      password[pos] ||= dig[6] if pos < times
      @index += 1
    end
    (0...times).map { |i| password[i] }.join
  end
end
