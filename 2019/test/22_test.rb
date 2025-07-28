# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/22_slam_shuffle')

class SlamShuffleTest < Minitest::Test
  def described_class = SlamShuffle

  def test_part1
    assert_equal [0, 3, 6, 9, 2, 5, 8, 1, 4, 7], described_class.new('deal with increment 7
deal into new stack
deal into new stack').process!(10)
  end

  def test_part1_b
    assert_equal [3, 0, 7, 4, 1, 8, 5, 2, 9, 6], described_class.new('cut 6
deal with increment 7
deal into new stack').process!(10)
  end

  def test_part1_c
    assert_equal [6, 3, 0, 7, 4, 1, 8, 5, 2, 9], described_class.new('deal with increment 7
deal with increment 9
cut -2').process!(10)
  end

  def test_part1_d
    assert_equal [9, 2, 5, 8, 1, 4, 7, 0, 3, 6], described_class.new('deal into new stack
cut -2
deal with increment 7
cut 8
cut -4
deal with increment 7
cut 3
deal with increment 9
deal with increment 3
cut -1').process!(10)
  end

  def test_part2_1
    res = [5, 4, 3, 2, 1, 0]

    res.each_with_index do |val, i|
      assert_equal val, described_class.new('deal into new stack').part2(6, i, 1)
    end
  end

  def test_part2_2
    res = [2, 3, 4, 5, 0, 1]

    res.each_with_index do |val, i|
      assert_equal val, described_class.new('cut 2').part2(6, i, 1)
    end
  end

  def test_part2_3
    res = [4, 5, 0, 1, 2, 3]

    res.each_with_index do |val, i|
      assert_equal val, described_class.new('cut -2').part2(6, i, 1)
    end
  end

  def test_part2_4
    res = [0, 5, 3, 1, 6, 4, 2]

    res.each_with_index do |val, i|
      assert_equal val, described_class.new('deal with increment 3').part2(7, i, 1)
    end
  end
end
