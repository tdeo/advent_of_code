# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/14_docking_data')

class DockingDataTest < Minitest::Test
  def described_class = DockingData

  def test_part1
    assert_equal 165, described_class.new('mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0').part1
  end

  def test_part2
    assert_equal 208, described_class.new('mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1').part2
  end
end
