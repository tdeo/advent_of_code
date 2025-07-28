# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/11_seating_system')

class SeatingSystemTest < Minitest::Test
  def described_class = SeatingSystem

  def test_part1
    assert_equal 37, described_class.new(<<~INPUT).part1
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
    INPUT
  end

  def test_part2
    assert_equal 26, described_class.new(<<~INPUT).part2
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
    INPUT
  end
end
