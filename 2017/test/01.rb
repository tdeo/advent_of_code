# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/01_inverse_capcha')

describe InverseCapcha do
  before { @k = InverseCapcha }

  def test_part1_1
    assert_equal 3, @k.new('1122').part1
  end

  def test_part1_2
    assert_equal 4, @k.new('1111').part1
  end

  def test_part1_3
    assert_equal 0, @k.new('1234').part1
  end

  def test_part1_4
    assert_equal 9, @k.new('91212129').part1
  end

  def test_part2_1
    assert_equal 6, @k.new('1212').part2
  end

  def test_part2_2
    assert_equal 0, @k.new('1221').part2
  end

  def test_part2_3
    assert_equal 4, @k.new('123425').part2
  end

  def test_part2_4
    assert_equal 12, @k.new('123123').part2
  end

  def test_part2_5
    assert_equal 4, @k.new('12131415').part2
  end
end
