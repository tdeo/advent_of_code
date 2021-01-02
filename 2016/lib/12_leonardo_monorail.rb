# frozen_string_literal: true

class LeonardoMonorail
  def initialize(input)
    @registers = Hash.new { |hash, key| hash[key] = /^-?\d+$/.match?(key) ? key.to_i : 0 }
    @instructions = input.split("\n")
    @index = 0
  end

  def val(key)
    /^-\d+$/.match?(key) ? key.to_i : @registers[key]
  end

  def execute!
    ins, x, y = @instructions[@index].split(' ')
    print! if x == 'h'
    case ins
    when 'cpy'
      @registers[y] = val(x)
    when 'inc'
      @registers[x] += 1
    when 'dec'
      @registers[x] -= 1
    when 'jnz'
      @index += y.to_i - 1 if @registers[x] != 0
    end
    @index += 1
  end

  def print!
    puts 'a'.upto('h').map { |l| @registers[l] }.join(' ')
  end

  def part1
    execute! while @instructions[@index]
    @registers['a']
  end

  def part2
    @registers['c'] = 1
    execute! while @instructions[@index]
    @registers['a']
  end
end
