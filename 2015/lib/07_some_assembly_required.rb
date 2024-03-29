# frozen_string_literal: true

class SomeAssemblyRequired
  MAX = (2**16) - 1

  def initialize(input)
    @input = input
    @queue = input.split("\n")
    @gates = {}
  end

  def value(gate_or_int)
    if /^\d+$/.match?(gate_or_int)
      gate_or_int.to_i
    else
      @gates[gate_or_int]
    end
  end

  def apply!
    ins = @queue.shift
    case
    when ins =~ /^([^\s]+) -> ([^\s]+)$/
      return @queue.push(ins) if value($1).nil?

      @gates[$2] = value($1)
    when ins =~ /^NOT ([^\s]+) -> ([^\s]+)$/
      return @queue.push(ins) if value($1).nil?

      @gates[$2] = value($1) ^ MAX
    when ins =~ /^([^\s]+) AND ([^\s]+) -> ([^\s]+)$/
      return @queue.push(ins) if value($1).nil? || value($2).nil?

      @gates[$3] = value($1) & value($2)
    when ins =~ /^([^\s]+) OR ([^\s]+) -> ([^\s]+)$/
      return @queue.push(ins) if value($1).nil? || value($2).nil?

      @gates[$3] = value($1) | value($2)
    when ins =~ /^([^\s]+) LSHIFT ([^\s]+) -> ([^\s]+)$/
      return @queue.push(ins) if value($1).nil? || value($2).nil?

      @gates[$3] = value($1) << value($2)
    when ins =~ /^([^\s]+) RSHIFT ([^\s]+) -> ([^\s]+)$/
      return @queue.push(ins) if value($1).nil? || value($2).nil?

      @gates[$3] = value($1) >> value($2)
    end
  end

  def part1
    apply! until @queue.empty?
    @gates['a']
  end

  def part2
    queue_bis = @queue.dup
    apply! until @queue.empty?
    @gates = { 'b' => @gates['a'] }
    @queue = queue_bis
    @queue.delete_if { |i| i[-2..] == ' b' }
    apply! until @queue.empty?
    @gates['a']
  end
end
