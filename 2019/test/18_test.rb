# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/18_many_worlds_interpretation')

class ManyWorldsInterpretationTest < Minitest::Test
  def described_class = ManyWorldsInterpretation

  def test_cycle
    refute_predicate described_class.new('
#########
#b.A.@.a#
#########'), :cycles?

    assert_predicate described_class.new('
#####
# @ #
# # #
#   #
#####'), :cycles?
  end

  def test_part1
    assert_equal 8, described_class.new('
#########
#b.A.@.a#
#########').part1
  end

  def test_part1_b
    assert_equal 86, described_class.new('
########################
#f.D.E.e.C.b.A.@.a.B.c.#
######################.#
#d.....................#
########################').part1
  end

  def test_part1_c
    assert_equal 132, described_class.new('
########################
#...............b.C.D.f#
#.######################
#.....@.a.B.c.d.A.e.F.g#
########################').part1
  end

  def test_part1_d
    assert_equal 136, described_class.new('
#################
#i.G..c...e..H.p#
########.########
#j.A..b...f..D.o#
########@########
#k.E..a...g..B.n#
########.########
#l.F..d...h..C.m#
#################').part1
  end

  def test_part1_e
    assert_equal 81, described_class.new('
########################
#@..............ac.GI.b#
###d#e#f################
###A#B#C################
###g#h#i################
########################').part1
  end

  def test_part2
    assert_equal 8, described_class.new('
#######
#a.#Cd#
##...##
##.@.##
##...##
#cB#Ab#
#######').part2
  end

  def test_part2_b
    assert_equal 32, described_class.new('
#############
#DcBa.#.GhKl#
#.###...#I###
#e#d#.@.#j#k#
###C#...###J#
#fEbA.#.FgHi#
#############').part2
  end

  def test_part2_c
    assert_equal 72, described_class.new('
#############
#g#f.D#..h#l#
#F###e#E###.#
#dCba...BcIJ#
#####.@.#####
#nK.L...G...#
#M###N#H###.#
#o#m..#i#jk.#
#############').part2
  end
end
