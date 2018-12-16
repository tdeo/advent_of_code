class ChronalClassification
  def initialize(input)
    @input = input
  end

  def valid?(operation, before, after)
    __send__(operation[0], *operation[1..-1], before)
    before == after
  end

  def addr(a, b, c, regs); regs[c] = regs[a] + regs[b]; end
  def addi(a, b, c, regs); regs[c]= regs[a] + b; end

  def mulr(a, b, c, regs); regs[c] = regs[a] * regs[b]; end
  def muli(a, b, c, regs); regs[c] = regs[a] * b; end

  def banr(a, b, c, regs); regs[c] = regs[a] & regs[b]; end
  def bani(a, b, c, regs); regs[c] = regs[a] & b; end

  def borr(a, b, c, regs); regs[c] = regs[a] | regs[b]; end
  def bori(a, b, c, regs); regs[c] = regs[a] | b; end

  def setr(a, _b, c, regs); regs[c] = regs[a]; end
  def seti(a, _b, c, regs); regs[c] = a; end

  def gtir(a, b, c, regs); regs[c] = (a > regs[b] ? 1 : 0); end
  def gtri(a, b, c, regs); regs[c] = (regs[a] > b ? 1 : 0); end
  def gtrr(a, b, c, regs); regs[c] = (regs[a] > regs[b] ? 1 : 0); end

  def eqir(a, b, c, regs); regs[c] = (a == regs[b] ? 1 : 0); end
  def eqri(a, b, c, regs); regs[c] = (regs[a] == b ? 1 : 0); end
  def eqrr(a, b, c, regs); regs[c] = (regs[a] == regs[b] ? 1 : 0); end

  def operations
    [:addr, :addi, :mulr, :muli, :banr, :bani, :borr, :bori, :setr, :seti, :gtir, :gtri, :gtrr, :eqir, :eqri, :eqrr]
  end

  def behave_like_3_or_more(operation, before, after)
    c = 0
    operations.each do |op|
      operation[0] = op
      c += 1 if valid?(operation, before.dup, after)
      return true if c >= 3
    end
    false
  end

  def part1
    c = 0
    @input.scan(/^Before: (.*)\n(.*)\nAfter: (.*)$/).each do |m|
      c += 1 if behave_like_3_or_more(
        m[1].split.map(&:to_i),
        eval(m[0]),
        eval(m[2]),
      )
    end
    c
  end

  def part2
    mapping = (0..15).map { |i| [i, operations] }.to_h

    @input.scan(/^Before: (.*)\n(.*)\nAfter: (.*)$/).each do |m|
      operation = m[1].split.map(&:to_i)
      before = eval(m[0])
      after = eval(m[2])
      mapping[operation[0]].dup.each do |op|
        mapping[operation[0]].delete(op) unless valid?([op] + operation[1..-1], before.dup, after)
      end
    end

    16.times do
      mapping.each_value do |v|
        next if v.size > 1
        mapping.each_value { |v2| v2.delete(v[0]) if v2.size > 1 }
      end
    end

    regs = [0, 0, 0, 0]
    @input.split("\n\n\n")[1].split("\n").each do |l|
      next if l.empty?
      operation = l.split(' ').map(&:to_i)
      __send__(mapping[operation[0]][0], *operation[1..-1], regs)
    end
    regs[0]
  end
end
