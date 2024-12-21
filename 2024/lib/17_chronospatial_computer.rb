# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'

class ChronospatialComputer
  extend T::Sig

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @a = T.let(0, Integer)
    @b = T.let(0, Integer)
    @c = T.let(0, Integer)
    @program = T.let([], T::Array[Integer])
    @idx = T.let(0, Integer)
    @output = T.let([], T::Array[Integer])
    parse!
  end

  sig { void }
  def parse!
    register_input, program = @input.split("\n\n")
    registers = T.let({}, T::Hash[Symbol, Integer])
    T.must(register_input).each_line(chomp: true) do |line|
      m = T.must(line.match(/^Register (\w+): (\d+)$/))
      registers[T.must(m[1]).to_sym] = m[2].to_i
    end
    @a = registers[:A] || 0
    @b = registers[:B] || 0
    @c = registers[:C] || 0
    @program = T.must(program).delete_prefix('Program: ').split(',').map(&:to_i)
    @idx = 0
    @output = []
  end

  sig { void }
  def perform_instruction!
    literal_operand = T.must(@program[@idx + 1])
    combo_operand = case literal_operand
                    when (0..3) then literal_operand
                    when 4 then @a
                    when 5 then @b
                    when 6 then @c
                    end
    case @program[@idx]
    when 0 then @a >>= T.must(combo_operand)
    when 1 then @b ^= literal_operand
    when 2 then @b = T.must(combo_operand) % 8
    when 3 then @idx = literal_operand - 2 if @a != 0
    when 4 then @b ^= @c
    when 5 then @output << (T.must(combo_operand) % 8)
    when 6 then @b = @a >> T.must(combo_operand)
    when 7 then @c = @a >> T.must(combo_operand)
    end
    @idx += 2
  end

  sig { returns(String) }
  def part1
    perform_instruction! while @idx < @program.size
    @output.join(',')
  end

  sig { params(output: Integer, a_target: Integer).returns(T::Array[Integer]) }
  def a_options(output, a_target)
    r = []
    t = a_target << 3
    (t...t + (1 << 3)).each do |i|
      parse!
      @a = i
      ((@program.size / 2) - 1).times { perform_instruction! }
      r << i if @output == [output]
    end
    r
  end

  sig { returns(Integer) }
  def part2
    opts = T.let([0], T::Array[Integer])
    @program.reverse_each do |val|
      opts = opts.flat_map { a_options(val, _1) }.uniq.sort
    end
    T.must(opts.min)
  end
end
