# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/15_beverage_bandits')

class BeverageBanditsTest < Minitest::Test
  def described_class = BeverageBandits

  def test_behaviour_1
    k = described_class.new('#######
#E..G.#
#...#.#
#.G.#G#
#######')
    elf = k.instance_variable_get(:@map).grid[1][1]

    assert_equal [1, 3], elf.destination
    assert_equal [1, 2], elf.best_move
  end

  def test_behaviour_2
    k = described_class.new('#########
#G..G..G#
#.......#
#.......#
#G..E..G#
#.......#
#.......#
#G..G..G#
#########')
    k.round

    assert_equal '#########
#.G...G.#
#...G...#
#...E..G#
#.G.....#
#.......#
#G..G..G#
#.......#
#########', k.repr(life: false)
    k.round

    assert_equal '#########
#..G.G..#
#...G...#
#.G.E.G.#
#.......#
#G..G..G#
#.......#
#.......#
#########', k.repr(life: false)
    k.round

    assert_equal '#########
#.......#
#..GGG..#
#..GEG..#
#G..G...#
#......G#
#.......#
#.......#
#########', k.repr(life: false)
  end

  def test_part1
    skip('Game ends during found 47 but this round was indeed completed and so should be counted')

    assert_equal [47, 590], described_class.new(<<~INPUT).part1(final_result: false)
      #######
      #.G...#
      #...EG#
      #.#.#G#
      #..G#E#
      #.....#
      #######
    INPUT
  end

  def test_part1_2
    assert_equal [37, 982], described_class.new(<<~INPUT).part1(final_result: false)
      #######
      #G..#E#
      #E#E.E#
      #G.##.#
      #...#E#
      #...E.#
      #######
    INPUT
  end

  def test_part1_3
    assert_equal [46, 859], described_class.new(<<~INPUT).part1(final_result: false)
      #######
      #E..EG#
      #.#G.E#
      #E.##E#
      #G..#.#
      #..E#.#
      #######
    INPUT
  end

  def test_part1_4
    assert_equal [35, 793], described_class.new(<<~INPUT).part1(final_result: false)
      #######
      #E.G#.#
      #.#G..#
      #G.#.G#
      #G..#.#
      #...E.#
      #######
    INPUT
  end

  def test_part1_5
    assert_equal [54, 536], described_class.new(<<~INPUT).part1(final_result: false)
      #######
      #.E...#
      #.#..G#
      #.###.#
      #E#G#G#
      #...#G#
      #######
    INPUT
  end

  def test_part1_6
    assert_equal [20, 937], described_class.new(<<~INPUT).part1(final_result: false)
      #########
      #G......#
      #.E.#...#
      #..##..G#
      #...##..#
      #...#...#
      #.G...G.#
      #.....G.#
      #########
    INPUT
  end
end
