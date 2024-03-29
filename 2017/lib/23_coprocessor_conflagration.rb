# frozen_string_literal: true

require 'prime'

class CoprocessorConflagration
  def initialize(input)
    @registers = Hash.new { |hash, key| hash[key] = /^-?\d+$/.match?(key) ? key.to_i : 0 }
    @instructions = input.split("\n")
    @index = 0
    @muls = 0
  end

  def val(key)
    /^-\d+$/.match?(key) ? key.to_i : @registers[key]
  end

  def execute!
    ins, x, y = @instructions[@index].split
    y = val(y)
    case ins
    when 'set'
      @registers[x] = y
    when 'sub'
      @registers[x] -= y
    when 'mul'
      @muls += 1
      @registers[x] *= y
    when 'jnz'
      @index += y - 1 if @registers[x] != 0
    end
    @index += 1
  end

  def print!
    puts 'a'.upto('h').map { |l| @registers[l] }.join(' ')
  end

  def part1
    execute! while @instructions[@index]
    @muls
  end

  def part2
    # rewriting the instructions leads to the following code,
    # in which we can recognize a primality test:
    # b = 106_700
    # c = 123_700
    # while true
    #   f = 1
    #   d = 2
    #   while d != b
    #     e = 2
    #     while e != b
    #       f = 0 if b == d * e
    #       e += 1
    #     end
    #     d += 1
    #   end
    #   h += 1 if f == 0
    #   exit if b == c
    #   b += 17
    # end
    @registers['a'] = 1
    12.times { execute! }
    b = @registers['b']
    c = @registers['c']
    h = 0
    loop do
      h += 1 unless Prime.prime?(b)
      break if b == c

      b += 17
    end
    h
  end
end
