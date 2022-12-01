# frozen_string_literal: true

class ArithmeticLogicUnit
  class ALU
    attr_accessor :vars, :initial_vars

    def initialize(input)
      @initial_vars = Hash.new(0)
      @instructions = input.split("\n").map(&:split)
    end

    def value_for(sym)
      case sym
      when /^-?\d+$/
        sym.to_i
      when /^[wxyz]$/
        @vars[sym]
      else
        raise "Unrecognized #{sym}"
      end
    end

    def apply(instruction)
      op, var1, var2 = instruction
      case op
      when 'inp'
        @vars[var1] = @inputs.shift
      when 'add'
        @vars[var1] += value_for(var2)
      when 'mul'
        @vars[var1] *= value_for(var2)
      when 'div'
        @vars[var1] /= value_for(var2)
      when 'mod'
        @vars[var1] = value_for(var1) % value_for(var2)
      when 'eql'
        @vars[var1] = value_for(var1) == value_for(var2) ? 1 : 0
      end
    end

    def perform(inputs)
      @inputs = inputs
      @vars = @initial_vars.dup
      @instructions.each do |instruction|
        apply(instruction)
      end
    end
  end

  def initialize(input)
    @input = input
  end

  def find_comb
    10_000.times do |value|
      vars = value + 0
      alu = ALU.new(@input)
      alu.initial_vars['w'] = vars % 10
      vars /= 10
      alu.initial_vars['x'] = vars % 10
      vars /= 10
      alu.initial_vars['y'] = vars % 10
      vars /= 10
      alu.initial_vars['z'] = vars % 10
      (1..9).each do |input|
        alu.perform([input])
        puts "#{input} #{alu.initial_vars}" if yield(alu)
      end
    end
  end

  def part1
    true
  end

  def part2
    true
  end
end
