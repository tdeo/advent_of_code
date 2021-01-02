# frozen_string_literal: true

require_relative '../../lib/iterate_with_cycle'

# rubocop:disable Style/GlobalVars

def inv(a)
  powmod(a, $n - 2) % $n
end

def powmod(a, k)
  return a if k == 1
  return 1 if k == 0

  b = powmod(a, k / 2)
  b = b**2 % $n
  b *= a if k.odd?
  b
end

class Mat22
  attr_reader :a, :b, :c, :d

  def initialize(r1, r2)
    @a, @b = r1
    @c, @d = r2
  end

  def dup
    self.class.new([@a, @b], [@c, @d])
  end

  def mul(o)
    aa = a * o.a + b * o.c
    bb = a * o.b + b * o.d
    cc = c * o.a + d * o.c
    dd = c * o.b + d * o.d
    @a = aa % $n
    @b = bb % $n
    @c = cc % $n
    @d = dd % $n
    self
  end

  def inspect
    [[@a, @b], [@c, @d]].inspect
  end

  def pow(k)
    return dup if k == 1

    a = dup.pow(k / 2)
    a.mul(a)
    k.even? ? a : a.mul(self)
  end
end

class SlamShuffle
  def initialize(input)
    @input = input
    @steps = input.strip.split("\n")
  end

  def shuffle!(step)
    case step
    when /^deal with increment (-?\d+)$/
      deal_with_increment($1.to_i)
    when 'deal into new stack'
      deal_into_new_stack
    when /^cut (-?\d+)$/
      cut($1.to_i)
    else
      raise "Unrecognized step #{step}"
    end
  end

  def deal_into_new_stack
    @deck.reverse!
  end

  def cut(n)
    @deck.rotate!(n)
  end

  def deal_with_increment(n)
    s = @deck.size
    new_deck = (0...s).map { nil }
    pos = 0
    s.times do |i|
      new_deck[pos] = @deck[i]
      pos = (pos + n) % s
    end
    @deck = new_deck
  end

  def process!(n = 10_007)
    @deck ||= (0...n).to_a
    @steps.each do |s|
      shuffle!(s)
    end
    @deck
  end

  def part1(n = 10_007)
    process!(n)
    @deck.find_index(2019)
  end

  def invmod(a, p)
    (a**(p - 2)) % p
  end

  def reverse_matrix(step)
    case step
    when 'deal into new stack'
      Mat22.new([-1, -1], [0, 1])
    when /^cut (-?\d+)$/
      c = $1.to_i * -1
      Mat22.new([1, -c], [0, 1])
    when /^deal with increment (-?\d+)$/
      c = $1.to_i
      Mat22.new([inv(c), 0], [0, 1])
    else
      raise "Unrecognized step #{step}"
    end
  end

  def part2(n = 119_315_717_514_047, pos = 2020, k = 101_741_582_076_661)
    $n = n

    m = Mat22.new([1, 0], [0, 1])
    @steps.each do |step|
      m.mul(reverse_matrix(step))
    end

    m = m.pow(k)
    (m.a * pos + m.b) % $n
  end
end

# rubocop:enable Style/GlobalVars
