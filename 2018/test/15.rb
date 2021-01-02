# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/15_beverage_bandits')

describe BeverageBandits do
  before { @k = BeverageBandits }

  def test_behaviour_1
    k = @k.new('#######
#E..G.#
#...#.#
#.G.#G#
#######')
    elf = k.instance_variable_get(:@map).grid[1][1]
    assert_equal [1, 3], elf.destination
    assert_equal [1, 2], elf.best_move
  end

  def test_behaviour_2
    k = @k.new('#########
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

  def xtest_part1
    assert_equal [47, 590], @k.new('
#######
#.G...#
#...EG#
#.#.#G#
#..G#E#
#.....#
#######
'.strip).part1(final_result: false)
  end

  def test_part1_2
    assert_equal [37, 982], @k.new('
#######
#G..#E#
#E#E.E#
#G.##.#
#...#E#
#...E.#
#######
'.strip).part1(final_result: false)
  end

  def test_part1_3
    assert_equal [46, 859], @k.new('
#######
#E..EG#
#.#G.E#
#E.##E#
#G..#.#
#..E#.#
#######
'.strip).part1(final_result: false)
  end

  def test_part1_4
    assert_equal [35, 793], @k.new('
#######
#E.G#.#
#.#G..#
#G.#.G#
#G..#.#
#...E.#
#######
'.strip).part1(final_result: false)
  end

  def test_part1_5
    assert_equal [54, 536], @k.new('
#######
#.E...#
#.#..G#
#.###.#
#E#G#G#
#...#G#
#######
'.strip).part1(final_result: false)
  end

  def test_part1_6
    assert_equal [20, 937], @k.new('
#########
#G......#
#.E.#...#
#..##..G#
#...##..#
#...#...#
#.G...G.#
#.....G.#
#########
'.strip).part1(final_result: false)
  end
end
