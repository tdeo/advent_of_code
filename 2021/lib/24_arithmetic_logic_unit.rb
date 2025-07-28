# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require 'active_support/all'

class ArithmeticLogicUnit
  extend T::Sig

  Vars = T.type_alias { T::Hash[String, Integer] }
  Instructions = T.type_alias { T::Array[T::Array[String]] }

  sig { params(input: String).void }
  def initialize(input)
    @input = input
    @instructions = T.let(input.split("\n").map(&:split), Instructions)
  end

  sig { params(instructions: Instructions, input: Vars, output: Vars).returns(T::Boolean) }
  def valid?(instructions, input, output)
    vals = perform(instructions, input)
    output.all? { |k, v| vals[k] == v }
  end

  sig { params(instructions: Instructions, input: Vars, stdin: T::Array[String]).returns(Vars) }
  def perform(instructions, input, stdin = [])
    vals = input.dup
    instructions.each do |ins|
      op, k, b = ins
      k = T.must(k)
      a = vals[k] || 0
      b = (vals.key?(b || '') ? vals[T.must(b)] : b).to_i
      vals[k] = case op
                when 'add' then a + b
                when 'mul' then a * b
                when 'div' then a / b
                when 'mod' then a % b
                when 'eql' then a == b ? 1 : 0
                when 'inp' then T.must(stdin.shift).to_i
                else raise
                end
    end
    vals
  end

  sig { returns(Integer) }
  def part1
    blocks = @instructions.split { _1[0] == 'inp' }.reject(&:empty?)

    ancestors = T.let({ 0 => '' }, T::Hash[Integer, String])
    blocks.each_with_index do |block, i|
      max_z = 1
      (blocks[(i + 1)..] || []).flatten(1).each do |ins|
        next unless ins[0] == 'div' && ins[1] == 'z'

        max_z *= ins[2].to_i
      end

      a2 = T.let({}, T::Hash[Integer, String])

      ancestors.each_key do |z|
        (1..9).each do |w|
          res = T.must(perform(block, { 'w' => w, 'z' => z })['z'])
          next unless res < max_z

          a2[res] ||= ''
          a2[res] = T.must([a2[res], "#{ancestors[z]}#{w}"].max)
        end
      end
      ancestors = a2
    end
    ancestors[0].to_i
  end

  sig { returns(Integer) }
  def part2
    blocks = @instructions.split { _1[0] == 'inp' }.reject(&:empty?)

    ancestors = T.let({ 0 => '' }, T::Hash[Integer, String])
    blocks.each_with_index do |block, i|
      max_z = 1
      (blocks[(i + 1)..] || []).flatten(1).each do |ins|
        next unless ins[0] == 'div' && ins[1] == 'z'

        max_z *= ins[2].to_i
      end

      a2 = T.let({}, T::Hash[Integer, String])

      ancestors.each_key do |z|
        (1..9).each do |w|
          res = T.must(perform(block, { 'w' => w, 'z' => z })['z'])
          next unless res < max_z

          a2[res] ||= 'z'
          a2[res] = T.must([a2[res], "#{ancestors[z]}#{w}"].min)
        end
      end
      ancestors = a2
    end
    ancestors[0].to_i
  end
end
