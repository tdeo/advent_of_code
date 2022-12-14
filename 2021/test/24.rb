# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/24_arithmetic_logic_unit')

describe ArithmeticLogicUnit do
  let(:described_class) { ArithmeticLogicUnit }
  let(:input) { '' }

  def xtest_part1
    assert described_class.new(<<~INPUT).find_comb { _1.vars['z'] == 0 }
      inp w
      mul x 0
      add x z
      mod x 26
      div z 26
      add x -7
      eql x w
      eql x 0
      mul y 0
      add y 25
      mul y x
      add y 1
      mul z y
      mul y 0
      add y w
      add y 3
      mul y x
      add z y
    INPUT
  end

  def xtest_part2
    assert described_class.new(input).part2
  end
end
