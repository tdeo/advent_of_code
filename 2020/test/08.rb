# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/08_handheld_halting')

describe HandheldHalting do
  before { @k = HandheldHalting }

  def test_part1
    assert_equal 5, @k.new('nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6').part1
  end

  def test_part2
    assert_equal 8, @k.new('nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6').part2
  end
end
