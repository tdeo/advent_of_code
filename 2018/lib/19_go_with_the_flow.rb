# frozen_string_literal: true

class GoWithTheFlow
  def initialize(input)
    @input = input
    @instructions = @input.split("\n").map do |ins|
      i = ins.split(' ')
      i[1..].map(&:to_i).unshift(i[0])
    end
    i = @instructions.shift
    raise 'Invalid #ip instruction' unless i[0] == '#ip'

    @bound_to = i[1]
    @regs = Hash.new { |h, k| h[k] = 0 }
    @ptr = 0
  end

  def addr(a, b, c)
    @regs[c] = @regs[a] + @regs[b]
  end

  def addi(a, b, c)
    @regs[c] = @regs[a] + b
  end

  def mulr(a, b, c)
    @regs[c] = @regs[a] * @regs[b]
  end

  def muli(a, b, c)
    @regs[c] = @regs[a] * b
  end

  def banr(a, b, c)
    @regs[c] = @regs[a] & @regs[b]
  end

  def bani(a, b, c)
    @regs[c] = @regs[a] & b
  end

  def borr(a, b, c)
    @regs[c] = @regs[a] | @regs[b]
  end

  def bori(a, b, c)
    @regs[c] = @regs[a] | b
  end

  def setr(a, _b, c)
    @regs[c] = @regs[a]
  end

  def seti(a, _b, c)
    @regs[c] = a
  end

  def gtir(a, b, c)
    @regs[c] = (a > @regs[b] ? 1 : 0)
  end

  def gtri(a, b, c)
    @regs[c] = (@regs[a] > b ? 1 : 0)
  end

  def gtrr(a, b, c)
    @regs[c] = (@regs[a] > @regs[b] ? 1 : 0)
  end

  def eqir(a, b, c)
    @regs[c] = (a == @regs[b] ? 1 : 0)
  end

  def eqri(a, b, c)
    @regs[c] = (@regs[a] == b ? 1 : 0)
  end

  def eqrr(a, b, c)
    @regs[c] = (@regs[a] == @regs[b] ? 1 : 0)
  end

  def round!
    ins = @instructions[@ptr]
    @regs[@bound_to] = @ptr
    __send__(ins[0], *ins[1..])
    @ptr = @regs[@bound_to] + 1
  end

  def regs
    (0..5).map { |i| @regs[i] }.join(', ')
  end

  def part1
    while @ptr >= 0 && @ptr < @instructions.size
      # print "ip=#{@regs[@bound_to]} [#{regs}] #{@instructions[@regs[@bound_to]].join(' ')}"
      round!
      # puts " [#{regs}]"
    end
    @regs[0]
  end

  def divisor_sum(a)
    require 'prime'
    r = 1
    a.prime_division.each do |p, pow|
      r *= (p**(pow + 1) - 1) / (p - 1)
    end
    r
  end

  def part2
    # The program can be decompiled in obeserving it returns the sum of divisors
    # of r2 after an initialisation phase. Line numbers kept and commented:
    #
    # GOTO 17
    # r3 = 1
    # while true
    #   r5 = 1
    #   while r5 <= r2
    #
    #
    #     r0 += r3 if (r2 == r3 * r5)
    #     r5 += 1
    #
    #
    #   end
    #   r3 += 1
    #
    #   exit 0 if r2 > r3
    # end
    #
    #
    # First initialization part, directly executed after GOTO 17
    # r2 += 2
    # r2 = r2 * r2 * 19 * 11   => 4 * 19 * 11 = 836
    #
    # r4 = 0
    # r4 = (r4 + 7) * 22 + 13  => 7 * 22 + 13 = 167
    # r2 += r4                 => r2 = 1003
    #
    # GOTO 1 if r0 == 0
    #
    #
    # Second initialization part, only executed when r0 != 0
    #
    #
    #
    # r2 += (27 * 28 + 29) * 30 * 14 * 32  => r2 = 1003 + 10550400 = 10551403
    # r0 = 0
    # GOTO 1

    @regs[0] = 1
    round! while @ptr != 2
    divisor_sum(@regs[2])
  end
end
