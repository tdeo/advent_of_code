require 'minitest/autorun'
require_relative '../lib/03_spiral_memory.rb'

class SpiralMemoryTest < MiniTest::Test
  def test_part1_1
    assert_equal 0, SpiralMemory.new(1).part1
  end

  def test_part1_2
    assert_equal 3, SpiralMemory.new(12).part1
  end

  def test_part1_3
    assert_equal 2, SpiralMemory.new(23).part1
  end

  def test_part1_4
    assert_equal 31, SpiralMemory.new(1024).part1
  end

  def test_part2_1
    assert_equal 362, SpiralMemory.new(351).part2
  end

  def test_part2_2
    assert_equal 351, SpiralMemory.new(350).part2
  end

  def test_part2_3
    assert_equal 10, SpiralMemory.new(6).part2
  end
end
