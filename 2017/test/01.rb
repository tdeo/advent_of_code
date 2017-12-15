require 'minitest/autorun'
require_relative '../lib/01_inverse_capcha'

class InvertCapchaTest < MiniTest::Test
  def test_part1_1
    assert_equal 3, InverseCapcha.new(1122).part1
  end

  def test_part1_2
    assert_equal 4, InverseCapcha.new(1111).part1
  end

  def test_part1_3
    assert_equal 0, InverseCapcha.new(1234).part1
  end

  def test_part1_4
    assert_equal 9, InverseCapcha.new(91212129).part1
  end

  def test_part2_1
    assert_equal 6, InverseCapcha.new(1212).part2
  end

  def test_part2_2
    assert_equal 0, InverseCapcha.new(1221).part2
  end

  def test_part2_3
    assert_equal 4, InverseCapcha.new(123425).part2
  end

  def test_part2_4
    assert_equal 12, InverseCapcha.new(123123).part2
  end

  def test_part2_5
    assert_equal 4, InverseCapcha.new(12131415).part2
  end
end
