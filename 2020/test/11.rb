# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/11_seating_system')

describe SeatingSystem do
  before { @k = SeatingSystem }

  def xtest_part1
    assert_equal 37, @k.new('L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL').part1
  end

  def xtest_part2
    assert_equal 26, @k.new('L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL').part2
  end
end
