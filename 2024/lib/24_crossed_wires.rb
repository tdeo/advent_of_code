# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class CrossedWires
  extend T::Sig

  class Op < T::Enum
    enums do
      OR = new('OR')
      XOR = new('XOR')
      AND = new('AND')
    end
  end

  class Gate
    extend T::Sig

    sig { returns(String) }
    attr_accessor :output

    sig { returns(Op) }
    attr_accessor :op

    sig { returns(T::Array[String]) }
    attr_reader :inputs

    sig { params(line: String).void }
    def initialize(line)
      parsed = T.must(/^(\w+) (AND|OR|XOR) (\w+) -> (\w+)$/.match(line))

      @inputs = T.let([T.must(parsed[1]), T.must(parsed[3])].sort, T::Array[String])
      @output = T.let(T.must(parsed[4]), String)
      @op = T.let(Op.deserialize(parsed[2]), Op)
    end

    sig { void }
    def print
      puts [@inputs[0], @op.serialize.ljust(3, ' '), @inputs[1], '->', @output].join(' ')
    end

    sig { params(wires: T::Hash[String, T::Boolean]).void }
    def apply!(wires)
      return unless doable?(wires)

      arg = @inputs.map { wires[_1] }
      wires[@output] = T.must(
        case @op
        when Op::OR then arg[0] || arg[1]
        when Op::AND then arg[0] && arg[1]
        when Op::XOR then arg[0] ^ arg[1]
        else T.absurd(@op)
        end,
      )
    end

    sig { params(wires: T::Hash[String, T::Boolean]).returns(T::Boolean) }
    def doable?(wires)
      @inputs.all? { !wires[_1].nil? }
    end

    sig { params(wires: T::Hash[String, T::Boolean]).returns(T::Boolean) }
    def done?(wires)
      !wires[@output].nil?
    end
  end

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @wires = T.let({}, T::Hash[String, T::Boolean])
    @gates = T.let([], T::Array[Gate])

    input.each_line(chomp: true) do |line|
      if (m = line.match(/^(\w+): (\d)$/))
        @wires[T.must(m[1])] = (m[2].to_i == 1)
      elsif line.include?('->')
        @gates << Gate.new(line)
      end
    end
  end

  sig { returns(Integer) }
  def z_value
    keys = @wires.keys.filter { _1.start_with?('z') }.sort.reverse
    keys.map { @wires[_1] ? '1' : '0' }.join.to_i(2)
  end

  sig { returns(Integer) }
  def part1
    loop do
      @gates.each { _1.apply!(@wires) }
      break if @gates.all? { _1.done?(@wires) }
    end
    z_value
  end

  sig { returns(T::Boolean) }
  def cyclic?
    wires = @wires.keys.grep(/^[xy]/).to_h { [_1, T.let(true, T::Boolean)] }
    loop do
      break if @gates.none? { _1.doable?(wires) && !_1.done?(wires) }

      @gates.each { _1.apply!(wires) }
    end

    wires.keys.count { !_1.start_with?('x', 'y') } < @gates.size
  end

  sig { params(outputs: T::Array[String]).void }
  def swap!(outputs)
    g1 = gate(T.must(outputs[0]))
    g2 = gate(T.must(outputs[1]))
    g1.output, g2.output = g2.output, g1.output
  end

  sig { void }
  def sort_gates!
    sorted = T.let([], T::Array[Gate])

    loop do
      batch = @gates.filter { _1.doable?(@wires) }.sort_by(&:inputs)
      sorted |= batch

      @gates.filter { _1.doable?(@wires) }.each { _1.apply!(@wires) }
      break if @gates.all? { _1.done?(@wires) }
    end

    @gates = sorted
  end

  sig { params(expected: Integer).void }
  def debug!(expected)
    puts "   #{Array.new(10) { '.'.ljust(5, ' ') }.join}"
    puts "x: #{@wires.keys.grep(/^x/).sort.map { @wires[_1] ? '1' : '0' }.join}"
    puts "y: #{@wires.keys.grep(/^y/).sort.map { @wires[_1] ? '1' : '0' }.join}"
    puts "z: #{@wires.keys.grep(/^z/).sort.map { @wires[_1] ? '1' : '0' }.join}"
    puts "   #{expected.to_s(2).reverse}"
  end

  sig { params(key: String).returns(T::Array[String]) }
  def ancestors(key)
    return [] if key.start_with?('x', 'y')

    gate = gate(key)
    return [] if gate.nil?

    res = T.let([gate.output], T::Array[String])
    gate.inputs.each { res |= ancestors(_1) }
    res.sort
  end

  sig { params(key: String).returns(Gate) }
  def gate(key)
    T.must(@gates.find { _1.output == key })
  end

  sig { params(bit: Integer).returns(T::Boolean) }
  def valid_for?(bit)
    20.times do
      x = Random.rand((1 << bit)...(1 << (bit + 1))).to_i
      y = Random.rand(0...(1 << (bit + 1)) - x).to_i
      @wires.clear
      (0..44).each do |i|
        @wires["x#{i.to_s.rjust(2, '0')}"] = (x[i] == 1)
        @wires["y#{i.to_s.rjust(2, '0')}"] = (y[i] == 1)
      end

      part1
      next if z_value == x + y

      return false if z_value != x + y
    end

    true
  end

  sig { returns(T.nilable(Integer)) }
  def first_invalid
    (0..44).find do |i|
      !valid_for?(i)
    end
  end

  sig { returns(String) }
  def part2
    # Not very deterministic, may need a few runs
    res = []

    while (tofix = first_invalid)
      options1 = ancestors("z#{tofix.to_s.rjust(2, '0')}") -
                 ancestors("z#{(tofix - 1).to_s.rjust(2, '0')}")
      options2 = ancestors("z#{(tofix + 1).to_s.rjust(2, '0')}") -
                 ancestors("z#{tofix.to_s.rjust(2, '0')}")

      options1.shuffle.product(options2.shuffle).find do |swap|
        print '.'
        swap!(swap)
        if cyclic?
          swap!(swap)
          next
        end

        if (first_invalid || Float::INFINITY) > tofix
          puts swap.join(',')
          res.concat(swap)
          next true
        end
        swap!(swap)
        false
      end || raise
    end

    res.sort.join(',')
  end
end
