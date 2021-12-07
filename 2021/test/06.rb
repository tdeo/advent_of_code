# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/06_lanternfish')

describe Lanternfish do
  before { @k = Lanternfish }

  def test_part1
    assert_equal 26, @k.new(<<~INPUT).part1(18)
      3,4,3,1,2
    INPUT
  end

  def test_part1_2
    assert_equal 5934, @k.new(<<~INPUT).part1
      3,4,3,1,2
    INPUT
  end

  def test_part2
    assert_equal 26_984_457_539, @k.new(<<~INPUT).part2
      3,4,3,1,2
    INPUT
  end
end
