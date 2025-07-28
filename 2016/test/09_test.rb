# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/09_explosives')

class ExplosivesTest < Minitest::Test
  def described_class = Explosives

  def test_part1_1
    assert_equal 6, described_class.new('ADVENT').part1
  end

  def test_part1_2
    assert_equal 7, described_class.new('A(1x5)BC').part1
  end

  def test_part1_3
    assert_equal 9, described_class.new('(3x3)XYZ').part1
  end

  def test_part1_4
    assert_equal 11, described_class.new('A(2x2)BCD(2x2)EFG').part1
  end

  def test_part1_5
    assert_equal 6, described_class.new('(6x1)(1x3)A').part1
  end

  def test_part1_6
    assert_equal 18, described_class.new('X(8x2)(3x3)ABCY').part1
  end

  def test_part2_1
    assert_equal 9, described_class.new('(3x3)XYZ').part2
  end

  def test_part2_2
    assert_equal 20, described_class.new('X(8x2)(3x3)ABCY').part2
  end

  def test_part2_3
    assert_equal 241_920, described_class.new('(27x12)(20x12)(13x14)(7x10)(1x12)A').part2
  end

  def test_part2_4
    assert_equal 445, described_class.new('(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN').part2
  end
end
