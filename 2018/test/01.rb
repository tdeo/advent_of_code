# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/01_chronal_calibration')

describe ChronalCalibration do
  before { @k = ChronalCalibration }

  def test_part1
    assert_equal 3, @k.new("+1\n-2\n+3\n+1").part1
  end

  def test_part1_2
    assert_equal 3, @k.new("+1\n+1\n+1").part1
  end

  def test_part1_3
    assert_equal 0, @k.new("+1\n+1\n-2").part1
  end

  def test_part1_4
    assert_equal(-6, @k.new("-1\n-2\n-3").part1)
  end

  def test_part2
    assert_equal 2, @k.new("+1\n-2\n+3\n+1").part2
  end

  def test_part2_2
    assert_equal 0, @k.new("+1\n-1").part2
  end

  def test_part2_3
    assert_equal 10, @k.new("+3\n+3\n+4\n-2\n-4").part2
  end

  def test_part2_4
    assert_equal 5, @k.new("-6\n+3\n+8\n+5\n-6").part2
  end

  def test_part2_5
    assert_equal 14, @k.new("+7\n+7\n-2\n-7\n-4").part2
  end
end
