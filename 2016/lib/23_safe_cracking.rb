# frozen_string_literal: true

class SafeCracking
  def initialize(input)
    @registers = Hash.new { |hash, key| hash[key] = /^-?\d+$/.match?(key) ? key.to_i : 0 }
    @instructions = input.split("\n")
    @index = 0
  end

  def val(key)
    /^-\d+$/.match?(key) ? key.to_i : @registers[key]
  end

  def execute!
    ins, x, y = @instructions[@index].split
    print! if x == 'h'
    case ins
    when 'cpy'
      @registers[y] = val(x)
    when 'inc'
      @registers[x] += 1
    when 'dec'
      @registers[x] -= 1
    when 'jnz'
      @index += val(y).to_i - 1 if val(x) != 0
    when 'tgl'
      idx = val(x) + @index
      ins = (@instructions[idx] || '').split
      case ins.size
      when 2
        ins[0] = ins[0] == 'inc' ? 'dec' : 'inc'
      when 3
        ins[0] = ins[0] == 'jnz' ? 'cpy' : 'jnz'
      end
      @instructions[idx] = ins.join(' ') if @instructions[idx]
    end
    @index += 1
  end

  def print!
    puts 'a'.upto('h').map { |l| @registers[l] }.join(' ')
  end

  def part1
    @registers['a'] = 7
    execute! while @instructions[@index]
    @registers['a']
  end

  def part2
    @registers['a'] = 12
    # Here the trick is to understand what the code does, with is a! + 86*77
    (1..@registers['a']).reduce(1, :*) + (@instructions[19].split[1].to_i * @instructions[20].split[1].to_i)
  end
end
